import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/constants.dart';
import '../../utils/toast_helper.dart';
import '../../services/auth_service.dart';
import '../../models/auth/phone_registration_dtos.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  State<PhoneRegistrationScreen> createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  // Controllers
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  // Services
  final AuthService _authService = AuthService();

  // State variables
  bool _isLoading = false;
  bool _phoneAlreadyRegisteredError = false;
  bool _fieldTouched = false;

  @override
  void initState() {
    super.initState();

    // Add listener to track field interaction
    _phoneController.addListener(() {
      if (_phoneAlreadyRegisteredError && _phoneController.text.isNotEmpty) {
        setState(() {
          _phoneAlreadyRegisteredError = false;
        });
      }
    });

    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus && _phoneController.text.isNotEmpty) {
        setState(() {
          _fieldTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  // Validation
  String? _getPhoneError() {
    if (!_fieldTouched && _phoneController.text.isEmpty) {
      return null;
    }

    if (_phoneController.text.isEmpty) {
      return 'Phone number is required';
    }

    if (_phoneAlreadyRegisteredError) {
      return 'This phone number is already registered. Please try logging in.';
    }

    return null;
  }

  bool _isFormValid() {
    return _phoneController.text.isNotEmpty &&
        _phoneController.text.length == 11 &&
        !_phoneAlreadyRegisteredError;
  }

  // Client-side validation
  bool _validatePhoneNumber() {
    final phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      ToastHelper.showError(context, 'Please enter a valid phone number.');
      return false;
    }

    if (phoneNumber.length != 11) {
      ToastHelper.showError(
        context,
        'Phone number must be at least 11 digits long.',
      );
      return false;
    }

    return true;
  }

  // Check if error is a connection error
  bool _isConnectionError(ApiException error) {
    return error.message.contains('Unable to connect') ||
        error.message.contains('connection') ||
        error.message.contains('network');
  }

  // Main verification flow
  Future<void> _verifyPhoneNumber() async {
    // Mark field as touched
    setState(() {
      _fieldTouched = true;
    });

    // Client-side validation
    if (!_validatePhoneNumber()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _phoneAlreadyRegisteredError = false;
    });

    try {
      final phoneNumber = _phoneController.text.trim();

      // Step 1: Check if phone is already registered
      try {
        final checkResponse = await _authService.checkPhoneRegistered(
          CheckPhoneRegisteredRequest(phoneNumber: phoneNumber),
        );

        // If we get here, phone is already registered (200 OK)
        if (checkResponse.status == true) {
          setState(() {
            _phoneAlreadyRegisteredError = true;
            _isLoading = false;
          });

          if (mounted) {
            ToastHelper.showError(
              context,
              'This phone number is already registered. Please login with your phone number.',
            );
          }
          return;
        }
      } on ApiException catch (e) {
        // Check if it's a 404 MEMBER_NOT_FOUND - this is expected for new registration
        if (e.statusCode == 404 && e.apiResponseCode == 'MEMBER_NOT_FOUND') {
          // This is good! Phone is available for registration
          // Continue to send OTP
        } else if (_isConnectionError(e)) {
          setState(() {
            _isLoading = false;
          });

          if (mounted) {
            ToastHelper.showError(context, e.message);
          }

          // Show retry info after 2 seconds
          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            ToastHelper.showInfo(
              context,
              'Tap to retry when connection is restored',
            );
          }
          return;
        } else {
          // Other errors
          throw e;
        }
      }

      // Step 2: Send OTP
      final sendOtpResponse = await _authService.sendOtp(
        SendOtpRequest(phoneNumber: phoneNumber),
      );

      if (sendOtpResponse.status == true && sendOtpResponse.data != null) {
        // Extract data
        final otpData = sendOtpResponse.data!;
        final otpExpireTime = otpData.otpExpireTime ?? otpData.expiryTime ?? '';

        // Show success toast
        if (mounted) {
          ToastHelper.showSuccess(context, 'OTP sent to $phoneNumber');
        }

        // Reset form
        _resetForm();

        // Navigate to OTP verification screen
        if (mounted) {
          Navigator.pushNamed(
            context,
            AppRoutes.otpVerification,
            arguments: {
              'phoneNumber': phoneNumber,
              'otpExpireTime': otpExpireTime,
            },
          );
        }
      } else {
        throw ApiException(message: 'Failed to send OTP. Please try again.');
      }
    } on ApiException catch (e) {
      if (_isConnectionError(e)) {
        if (mounted) {
          ToastHelper.showError(context, e.message);
        }

        // Show retry info after 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          ToastHelper.showInfo(
            context,
            'Tap to retry when connection is restored',
          );
        }
      } else {
        if (mounted) {
          ToastHelper.showError(context, e.message);
        }
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'An unexpected error occurred. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resetForm() {
    _phoneController.clear();
    setState(() {
      _fieldTouched = false;
      _phoneAlreadyRegisteredError = false;
    });
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width <= 480;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: _buildCard(isSmallScreen),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isSmallScreen) {
    return MouseRegion(
      onEnter: (_) {
        // Add hover effect if needed
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(isSmallScreen),
            _buildForm(isSmallScreen),
            _buildFooter(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: isSmallScreen ? 30 : 40,
        left: isSmallScreen ? 20 : 30,
        right: isSmallScreen ? 20 : 30,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Phone Registration',
            style: TextStyle(
              fontSize: isSmallScreen ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your phone number to get started with DineEase',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(bool isSmallScreen) {
    final phoneError = _getPhoneError();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 30 : 40,
        vertical: isSmallScreen ? 20 : 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Phone Number Label
          const Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),

          // Phone Number Input
          Focus(
            onFocusChange: (hasFocus) {
              setState(() {});
            },
            child: TextField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                hintStyle: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 16,
                ),
                filled: true,
                fillColor: _phoneFocusNode.hasFocus
                    ? Colors.white
                    : const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE1E5E9),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE1E5E9),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF667EEA),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE74C3C),
                    width: 2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE74C3C),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                counterText: '',
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF212121)),
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (_) {
                if (_isFormValid() && !_isLoading) {
                  _verifyPhoneNumber();
                }
              },
            ),
          ),

          // Error Message
          if (phoneError != null) ...[
            const SizedBox(height: 8),
            Text(
              phoneError,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFE74C3C),
                fontFamily: 'Poppins',
              ),
            ),
          ],

          const SizedBox(height: 30),

          // Submit Button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isFormValid() && !_isLoading
                  ? _verifyPhoneNumber
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(
                  0xFF667EEA,
                ).withOpacity(0.6),
                disabledForegroundColor: Colors.white,
                elevation: _isFormValid() && !_isLoading ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Verifying...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'Verify Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 25 : 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account? ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF757575),
              fontFamily: 'Poppins',
            ),
          ),
          InkWell(
            onTap: _navigateToLogin,
            child: const Text(
              'Login here',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF667EEA),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
