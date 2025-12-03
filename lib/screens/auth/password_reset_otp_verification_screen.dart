import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../config/constants.dart';
import '../../utils/helpers.dart';
import '../../services/auth_service.dart';
import '../../models/sms/sms_dto.dart';

class PasswordResetOTPVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? otpExpireTime;

  const PasswordResetOTPVerificationScreen({
    super.key,
    this.phoneNumber,
    this.otpExpireTime,
  });

  @override
  State<PasswordResetOTPVerificationScreen> createState() =>
      _PasswordResetOTPVerificationScreenState();
}

class _PasswordResetOTPVerificationScreenState
    extends State<PasswordResetOTPVerificationScreen>
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
  int _timeLeft = 0;
  Timer? _timer;
  bool _otpError = false;
  bool _otpErrorExpire = false;
  String? _phoneNumber;
  DateTime? _expiryTimestamp;

  // Animation controller for shake effect
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  // Page reload protection
  bool _shouldWarnOnExit = true;

  @override
  void initState() {
    super.initState();

    // Setup shake animation
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // Initialize screen with timer and phone number
    _initializeScreen();

    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  Future<void> _initializeScreen() async {
    final prefs = await SharedPreferences.getInstance();

    // Get phone number from navigation or local storage
    String? phone = widget.phoneNumber;
    if (phone == null || phone.isEmpty) {
      phone = prefs.getString(StorageKeys.phoneNumber);
    }

    if (phone == null || phone.isEmpty) {
      // No phone number available - navigate back
      if (mounted) {
        ToastHelper.showError(
          context,
          'Phone number not found. Please try again.',
        );
        Navigator.of(context).pop();
      }
      return;
    }

    setState(() {
      _phoneNumber = phone;
    });

    // Store phone number for session persistence
    await prefs.setString('otp_phone_number', phone);

    // Initialize timer
    await _initializeTimer();
  }

  Future<void> _initializeTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTimestamp = prefs.getInt('otp_expiry_timestamp');
    final storedPhone = prefs.getString('otp_phone_number');

    DateTime expiryTime;

    // Check if we have a stored timer for this phone number
    if (storedTimestamp != null && storedPhone == _phoneNumber) {
      // Resume existing timer
      expiryTime = DateTime.fromMillisecondsSinceEpoch(storedTimestamp);
      final now = DateTime.now();
      final remainingSeconds = expiryTime.difference(now).inSeconds;

      if (remainingSeconds > 0) {
        // Timer still valid - resume
        setState(() {
          _expiryTimestamp = expiryTime;
          _timeLeft = remainingSeconds;
        });
        _startTimer();
        return;
      }
    }

    // Start new timer (5 minutes)
    final now = DateTime.now();
    expiryTime = now.add(const Duration(seconds: 300));

    // Parse expiry time from widget if available
    if (widget.otpExpireTime != null) {
      try {
        final parsedTime = DateTime.parse(widget.otpExpireTime!);
        if (parsedTime.isAfter(now)) {
          expiryTime = parsedTime;
        }
      } catch (e) {
        // Use default 5 minutes
      }
    }

    // Store expiry timestamp
    await prefs.setInt(
      'otp_expiry_timestamp',
      expiryTime.millisecondsSinceEpoch,
    );

    setState(() {
      _expiryTimestamp = expiryTime;
      _timeLeft = expiryTime.difference(now).inSeconds;
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_expiryTimestamp == null) {
        timer.cancel();
        return;
      }

      final now = DateTime.now();
      final remaining = _expiryTimestamp!.difference(now).inSeconds;

      setState(() {
        if (remaining > 0) {
          _timeLeft = remaining;
        } else {
          _timeLeft = 0;
          timer.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int _getFilledCount() {
    return _controllers.where((c) => c.text.isNotEmpty).length;
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

  Future<bool> _onWillPop() async {
    if (!_shouldWarnOnExit || _timeLeft == 0) {
      return true;
    }

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Leave Verification?'),
            content: const Text(
              'Are you sure you want to leave? Your OTP verification is in progress.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Leave'),
              ),
            ],
          ),
        ) ??
        false;
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

  Future<void> _verifyOTP() async {
    // Reset errors
    setState(() {
      _otpError = false;
      _otpErrorExpire = false;
    });

    // Check timer
    if (_timeLeft <= 0) {
      setState(() => _otpErrorExpire = true);
      ToastHelper.showError(
        context,
        'OTP has expired. Please request a new one.',
      );
      return;
    }

    // Check all fields are filled
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (!allFilled) {
      ToastHelper.showError(
        context,
        'Please enter all 6 digits of the OTP code',
      );
      return;
    }

    // Concatenate OTP
    final otp = _controllers.map((c) => c.text).join();

    setState(() => _isLoading = true);

    try {
      final request = SMSDto(
        phoneNumber: _phoneNumber,
        otp: otp,
        expiryTime: _expiryTimestamp?.toIso8601String(),
      );

      final response = await _authService.verifyPasswordResetOtp(request);

      if (mounted) {
        setState(() => _isLoading = false);

        // Check for success response code
        if (response.apiResponseCode == 'OTP_VERIFY_SUCCESS') {
          // Clear session storage
          await _clearOtpSession();

          // Disable exit warning
          setState(() => _shouldWarnOnExit = false);

          // Clear fields
          for (var controller in _controllers) {
            controller.clear();
          }

          // Stop timer
          _timer?.cancel();

          ToastHelper.showSuccess(context, 'OTP verified successfully!');

          // Navigate to password reset screen
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.passwordReset,
            arguments: {
              'phoneNumber': _phoneNumber,
              'name': response.data?.fullName ?? '',
            },
          );
        } else {
          // Generic error
          setState(() => _otpError = true);
          _shakeController.forward().then((_) => _shakeController.reverse());
          ToastHelper.showError(
            context,
            'Invalid/Expired OTP. Please check and try again.',
          );
        }
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);

        // Check if OTP expired
        if (e.message.toLowerCase().contains('expired')) {
          setState(() => _otpErrorExpire = true);
          ToastHelper.showError(context, 'OTP has Expired. Please try again.');
        } else {
          setState(() => _otpError = true);
          _shakeController.forward().then((_) => _shakeController.reverse());
          ToastHelper.showError(
            context,
            'Invalid/Expired OTP. Please check and try again.',
          );
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
      final request = SMSDto(phoneNumber: _phoneNumber);
      final response = await _authService.resendPasswordResetOtp(request);

      if (mounted) {
        setState(() => _isLoading = false);

        // Update expiry timestamp
        final now = DateTime.now();
        DateTime newExpiry = now.add(const Duration(seconds: 300));

        // Check if server provided expiry time
        if (response.data?.otpExpireTime != null) {
          try {
            final serverExpiry = DateTime.parse(response.data!.otpExpireTime!);
            if (serverExpiry.isAfter(now)) {
              newExpiry = serverExpiry;
            }
          } catch (e) {
            // Use default
          }
        }

        // Store new expiry timestamp
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(
          'otp_expiry_timestamp',
          newExpiry.millisecondsSinceEpoch,
        );

        setState(() {
          _expiryTimestamp = newExpiry;
          _timeLeft = newExpiry.difference(now).inSeconds;
        });

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
    } on ApiException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ToastHelper.showError(context, 'Failed to resend OTP');
      }
    }
  }

  Future<void> _clearOtpSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('otp_expiry_timestamp');
    await prefs.remove('otp_phone_number');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                                if (_phoneNumber != null)
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                          colors: [
                                            Color(0xFF667eea),
                                            Color(0xFF764ba2),
                                          ],
                                        ).createShader(bounds),
                                    child: Text(
                                      '+88 $_phoneNumber',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 32),

                                // OTP Input Fields
                                _buildOtpInputFields(),
                                const SizedBox(height: 16),

                                // Progress Indicator
                                _buildProgressIndicator(),

                                // Error Message
                                if (_otpError) const SizedBox(height: 16),
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
                                const SizedBox(height: 24),

                                // Verify Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: (_isLoading || _timeLeft == 0)
                                        ? null
                                        : _verifyOTP,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF667eea),
                                      disabledBackgroundColor: const Color(
                                        0xFFe2e8f0,
                                      ),
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
              // Clear the previous field
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
            if (index == 5 && _getFilledCount() == 6) {
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

  Widget _buildProgressIndicator() {
    final filledCount = _getFilledCount();

    // Only show when 1-5 digits are entered
    if (filledCount == 0 || filledCount == 6) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            '$filledCount/6 digits entered',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    if (_timeLeft > 0) {
      // Timer running
      final isUrgent = _timeLeft <= 60;
      final timeInMinutes = _timeLeft > 60;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFf1f5f9), Color(0xFFe2e8f0)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFcbd5e1), width: 1),
        ),
        child: Column(
          children: [
            Text(
              timeInMinutes
                  ? 'Expires in ${(_timeLeft / 60).ceil()} minutes'
                  : 'Expires in $_timeLeft seconds',
              style: const TextStyle(
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
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
            if (isUrgent) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFfef2f2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFfecaca)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFef4444),
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Please complete verification soon',
                      style: TextStyle(
                        color: Color(0xFFef4444),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    } else {
      // Timer expired - show resend section
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFfef2f2), Color(0xFFfee2e2)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFfecaca)),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _resendOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFef4444),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                        'Resend OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
