import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/constants.dart';
import '../../services/auth_service.dart';
import '../../services/storage_service.dart';
import '../../models/models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  final _storageService = StorageService();

  bool _isLoading = false;
  String? _globalErrorMessage;
  bool _isPhoneNumberTouched = false;
  bool _isPasswordTouched = false;
  String? _phoneNumberError;
  String? _passwordError;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    // REMOVE IN PRODUCTION - Pre-fill for development
    _phoneController.text = '01726967760';
    _passwordController.text = 'tuhin123';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    setState(() {
      if (_phoneController.text.isEmpty) {
        _phoneNumberError = 'Phone number is required';
      } else if (!RegExp(r'^[0-9]{11}$').hasMatch(_phoneController.text)) {
        _phoneNumberError = 'Please enter a valid 11-digit phone number';
      } else {
        _phoneNumberError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters long';
      } else {
        _passwordError = null;
      }
    });
  }

  bool _validateForm() {
    setState(() {
      _isPhoneNumberTouched = true;
      _isPasswordTouched = true;
    });

    _validatePhoneNumber();
    _validatePassword();

    return _phoneNumberError == null && _passwordError == null;
  }

  String _getErrorMessage(String apiResponseCode, String defaultMessage) {
    switch (apiResponseCode) {
      case 'NO_USER_EXIST':
        return 'User not found. Please check your phone number or sign up.';
      case 'INVALID_CREDENTIALS':
        return 'Invalid phone number or password. Please try again.';
      default:
        return defaultMessage;
    }
  }

  Future<void> _handleLogin() async {
    // Clear global error
    setState(() {
      _globalErrorMessage = null;
    });

    // Validate form
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create authentication request
      final request = AuthenticationRequest(
        phoneNumber: _phoneController.text,
        password: _passwordController.text,
      );

      // Call login API
      final response = await _authService.login(request);

      // Check if response is successful and has data
      if (response.isSuccess && response.data != null) {
        // Save authentication data
        await _storageService.saveAuthenticationData(response.data!);

        // Fetch dine information (non-blocking)
        try {
          final dineResponse = await _authService.fetchDineInfo(
            _phoneController.text,
          );
          if (dineResponse.status && dineResponse.data != null) {
            await _storageService.saveDineId(dineResponse.data!.id);
          }
        } catch (e) {
          // Log error but don't block navigation
          debugPrint('Failed to fetch dine info: $e');
        }

        // Clear form and reset state
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isPhoneNumberTouched = false;
            _isPasswordTouched = false;
          });

          _formKey.currentState?.reset();
          _phoneController.clear();
          _passwordController.clear();

          // Navigate to home
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _globalErrorMessage =
                response.message != null && response.message!.isNotEmpty
                ? response.message!
                : 'Login failed. Please try again.';
          });
        }
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _globalErrorMessage = _getErrorMessage(
            e.apiResponseCode ?? '',
            e.message,
          );
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _globalErrorMessage = 'Login failed. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Header
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 28.8,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF667EEA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Welcome back! sign in to your Dine.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF757575),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),

                              // Phone Number Field
                              _buildPhoneNumberField(),
                              const SizedBox(height: 20),

                              // Password Field
                              _buildPasswordField(),
                              const SizedBox(height: 12),

                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(AppRoutes.forgotPassword);
                                  },
                                  icon: const Icon(Icons.key, size: 16),
                                  label: const Text('Forgot Password?'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xFF667EEA),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Global Error Alert
                              if (_globalErrorMessage != null)
                                _buildErrorAlert(),
                              if (_globalErrorMessage != null)
                                const SizedBox(height: 20),

                              // Login Button
                              _buildLoginButton(),
                              const SizedBox(height: 24),

                              // Sign Up Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Color(0xFF757575)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pushNamed(AppRoutes.phoneRegistration);
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                        color: Color(0xFF667EEA),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.phone,
              size: 18,
              color: _isPhoneNumberTouched && _phoneNumberError != null
                  ? const Color(0xFFE74C3C)
                  : const Color(0xFF667EEA),
            ),
            const SizedBox(width: 8),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Enter your phone number',
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE1E5E9), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isPhoneNumberTouched && _phoneNumberError != null
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isPhoneNumberTouched && _phoneNumberError != null
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFF667EEA),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _globalErrorMessage = null;
              if (_isPhoneNumberTouched) {
                _validatePhoneNumber();
              }
            });
          },
          onTap: () {
            setState(() {
              _isPhoneNumberTouched = true;
            });
          },
        ),
        if (_isPhoneNumberTouched && _phoneNumberError != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _phoneNumberError!,
              style: const TextStyle(fontSize: 12, color: Color(0xFFE74C3C)),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.lock,
              size: 18,
              color: _isPasswordTouched && _passwordError != null
                  ? const Color(0xFFE74C3C)
                  : const Color(0xFF667EEA),
            ),
            const SizedBox(width: 8),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE1E5E9), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isPasswordTouched && _passwordError != null
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isPasswordTouched && _passwordError != null
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFF667EEA),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _globalErrorMessage = null;
              if (_isPasswordTouched) {
                _validatePassword();
              }
            });
          },
          onTap: () {
            setState(() {
              _isPasswordTouched = true;
            });
          },
        ),
        if (_isPasswordTouched && _passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _passwordError!,
              style: const TextStyle(fontSize: 12, color: Color(0xFFE74C3C)),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorAlert() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        border: Border.all(color: const Color(0xFFFECACA), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Color(0xFF991B1B), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _globalErrorMessage!,
              style: const TextStyle(fontSize: 14, color: Color(0xFF991B1B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF667EEA),
          disabledBackgroundColor: const Color(0xFF667EEA).withOpacity(0.6),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Signing in...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.login),
                  const SizedBox(width: 8),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}
