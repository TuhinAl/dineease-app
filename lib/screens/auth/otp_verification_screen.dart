import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../config/constants.dart';
import '../../utils/helpers.dart';
import '../../services/auth_service.dart';
import '../../models/auth/otp_dtos.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String? otpExpireTime;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.otpExpireTime,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  // Controllers for 6 OTP input fields
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Services
  final AuthService _authService = AuthService();

  // State variables
  bool _isLoading = false;
  int _timeLeft = 300; // 5 minutes in seconds
  Timer? _timer;
  bool _otpError = false;
  bool _otpErrorExpire = false;
  String? _expiryTime;

  // Animation controller for shake effect
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _expiryTime = widget.otpExpireTime;
    _startTimer();

    // Setup shake animation
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    _shakeController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeLeft > 0) {
            _timeLeft--;
          } else {
            _timer?.cancel();
          }
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _onDigitChanged(String value, int index) {
    // Reset error state
    setState(() {
      _otpError = false;
      _otpErrorExpire = false;
    });

    // Validate numeric input
    if (value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value)) {
      _controllers[index].clear();
      return;
    }

    // Auto-focus next field
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  // Note: Backspace handling is done via onChanged and field clearing
  // This method kept for future enhancement if needed

  Future<void> _verifyOTP() async {
    // Reset errors
    setState(() {
      _otpError = false;
      _otpErrorExpire = false;
    });

    // Check all fields are filled
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (!allFilled) {
      ToastHelper.showError(context, 'Please enter complete OTP code');
      return;
    }

    // Concatenate OTP
    final otp = _controllers.map((c) => c.text).join();

    setState(() => _isLoading = true);

    try {
      final request = VerifyOtpRequest(
        phoneNumber: widget.phoneNumber,
        otp: otp,
        expiryTime: _expiryTime,
      );

      final response = await _authService.verifyOtp(request);

      if (mounted) {
        setState(() => _isLoading = false);

        if (response.status == true) {
          // Clear fields
          for (var controller in _controllers) {
            controller.clear();
          }

          // Stop timer
          _timer?.cancel();

          ToastHelper.showSuccess(context, 'OTP verified successfully!');

          // Navigate to member registration
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.memberRegistration,
            arguments: {
              'phoneNumber': widget.phoneNumber,
              'adminFlag': response.data?.isAdmin ?? false,
            },
          );
        }
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);

        // Check if OTP expired
        if (e.message.toLowerCase().contains('expired')) {
          setState(() => _otpErrorExpire = true);
          ToastHelper.showError(context, 'Please try again. OTP has Expired.');
        } else {
          setState(() => _otpError = true);
          _shakeController.forward().then((_) => _shakeController.reverse());
          ToastHelper.showError(context, 'Verification failed - ${e.message}');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ToastHelper.showError(context, 'An unexpected error occurred');
      }
    }
  }

  Future<void> _resendOTP() async {
    // Reset state
    setState(() {
      _timeLeft = 300;
      _otpError = false;
      _otpErrorExpire = false;
      _isLoading = true;
    });

    // Clear all fields
    for (var controller in _controllers) {
      controller.clear();
    }

    _timer?.cancel();

    try {
      final request = ResendOtpRequest(phoneNumber: widget.phoneNumber);
      final response = await _authService.resendOtp(request);

      if (mounted) {
        setState(() => _isLoading = false);

        if (response.status == true) {
          // Update expiry time
          _expiryTime =
              response.data?.expiryTime ?? response.data?.otpExpireTime;

          // Start new timer
          _startTimer();

          ToastHelper.showSuccess(
            context,
            'OTP has been resent to your phone number',
          );

          // Auto-focus first field
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              _focusNodes[0].requestFocus();
            }
          });
        }
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _timeLeft = 300; // Keep timer ready for retry
        });
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _timeLeft = 300;
        });
        ToastHelper.showError(context, 'Failed to resend OTP');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.white.withOpacity(0.95),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'OTP Verification',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Instruction text
                              const Text(
                                'Enter the 6-digit code sent to your phone',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF64748b),
                                  fontFamily: 'Inter',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),

                              // Phone number display
                              Text(
                                '+88 ${widget.phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF667eea),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 32),

                              // OTP Input Fields
                              _buildOtpInputFields(),
                              const SizedBox(height: 24),

                              // Error Message
                              if (_otpError)
                                AnimatedOpacity(
                                  opacity: _otpError ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFfef2f2),
                                      border: Border.all(
                                        color: const Color(0xFFfecaca),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Invalid/Expired OTP. Please check and try again.',
                                      style: TextStyle(
                                        color: Color(0xFFef4444),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              if (_otpError) const SizedBox(height: 24),

                              // Verify Button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _verifyOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF667eea),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Verify OTP',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Timer Section
                              _buildTimerSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: _otpError
              ? Offset(
                  _shakeAnimation.value *
                      ((_shakeController.value * 2 - 1).abs() * 2 - 1),
                  0,
                )
              : Offset.zero,
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) => _buildOtpDigitField(index)),
      ),
    );
  }

  Widget _buildOtpDigitField(int index) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 400;
    final isMobile = MediaQuery.of(context).size.width <= 600;

    double fieldWidth = 60;
    double fieldHeight = 70;
    double fontSize = 24;
    double gap = 12;

    if (isSmallScreen) {
      fieldWidth = 45;
      fieldHeight = 55;
      fontSize = 18;
      gap = 6;
    } else if (isMobile) {
      fieldWidth = 50;
      fieldHeight = 60;
      fontSize = 20;
      gap = 8;
    }

    return Container(
      width: fieldWidth,
      height: fieldHeight,
      margin: EdgeInsets.symmetric(horizontal: gap / 2),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            // If current field is empty and backspace is pressed, move to previous field
            if (_controllers[index].text.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
              // Optionally clear the previous field
              _controllers[index - 1].clear();
            }
          }
        },
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: _focusNodes[index].hasFocus
                ? Colors.white
                : const Color(0xFFf8fafc),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _otpError
                    ? const Color(0xFFef4444)
                    : const Color(0xFFe2e8f0),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _otpError
                    ? const Color(0xFFef4444)
                    : const Color(0xFFe2e8f0),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
            ),
          ),
          onChanged: (value) => _onDigitChanged(value, index),
          onTap: () {
            setState(() {}); // Rebuild to update focus state
          },
          onEditingComplete: () {
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            }
          },
          onSubmitted: (value) {
            if (index == 5) {
              _verifyOTP();
            }
          },
          onTapOutside: (_) {
            setState(() {}); // Rebuild to update focus state
          },
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    if (_timeLeft > 0) {
      // Timer running
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFf1f5f9), Color(0xFFe2e8f0)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'OTP expires in',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748b),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ).createShader(bounds),
              child: Text(
                _formatTime(_timeLeft),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_otpErrorExpire) {
      // Timer expired with error state
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFfef2f2), Color(0xFFfee2e2)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'OTP has expired',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFef4444),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _resendOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFef4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Resend OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Timer expired - show resend link
      return Column(
        children: [
          const Text(
            "Didn't receive the code?",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748b),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _isLoading ? null : _resendOTP,
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF667eea),
                fontFamily: 'Inter',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      );
    }
  }
}
