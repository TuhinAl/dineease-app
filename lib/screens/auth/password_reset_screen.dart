import 'package:flutter/material.dart';
import 'dart:async';
import '../../config/app_theme.dart';
import '../../config/constants.dart';
import '../../services/auth_service.dart';
import '../../models/auth/password_reset_dtos.dart';
import '../../utils/helpers.dart';

class PasswordResetScreen extends StatefulWidget {
  final String phoneNumber;
  final String? name;

  const PasswordResetScreen({super.key, required this.phoneNumber, this.name});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen>
    with SingleTickerProviderStateMixin {
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Focus nodes
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  // Services
  final AuthService _authService = AuthService();

  // State variables
  bool _isLoading = false;
  bool _newPasswordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _newPasswordTouched = false;
  bool _confirmPasswordTouched = false;

  // Animation controller for card entrance
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();

    // Add listeners to track field interactions
    _newPasswordFocusNode.addListener(() {
      if (!_newPasswordFocusNode.hasFocus && !_newPasswordTouched) {
        setState(() => _newPasswordTouched = true);
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus && !_confirmPasswordTouched) {
        setState(() => _confirmPasswordTouched = true);
      }
    });

    // Listen to text changes for real-time validation
    _newPasswordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Validation Methods
  bool get _isPasswordValidLength =>
      _newPasswordController.text.trim().length >= 6;

  bool get _passwordsMatch =>
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _newPasswordController.text == _confirmPasswordController.text;

  bool get _isFormValid =>
      _newPasswordController.text.trim().length >= 6 &&
      _confirmPasswordController.text.isNotEmpty &&
      _passwordsMatch;

  // Get validation state for password field
  ValidationState _getPasswordValidationState() {
    if (!_newPasswordTouched && _newPasswordController.text.isEmpty) {
      return ValidationState.none;
    }

    if (_newPasswordController.text.isEmpty && _newPasswordTouched) {
      return ValidationState.error;
    }

    if (_newPasswordController.text.isNotEmpty &&
        _newPasswordController.text.length < 6) {
      return ValidationState.info;
    }

    if (_isPasswordValidLength) {
      return ValidationState.success;
    }

    return ValidationState.none;
  }

  // Get validation state for confirm password field
  ValidationState _getConfirmPasswordValidationState() {
    if (!_confirmPasswordTouched && _confirmPasswordController.text.isEmpty) {
      return ValidationState.none;
    }

    if (_confirmPasswordController.text.isEmpty && _confirmPasswordTouched) {
      return ValidationState.error;
    }

    if (_confirmPasswordController.text.isNotEmpty && !_passwordsMatch) {
      return ValidationState.error;
    }

    return ValidationState.none;
  }

  // Password reset handler
  Future<void> _handlePasswordReset() async {
    // Mark fields as touched
    setState(() {
      _newPasswordTouched = true;
      _confirmPasswordTouched = true;
    });

    if (!_isFormValid) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = PasswordResetRequest(
        phoneNumber: widget.phoneNumber,
        password: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );

      final response = await _authService.resetPassword(request);

      if ((response.status ?? false) && mounted) {
        // Show success message
        ToastHelper.showSuccess(context, 'Password updated successfully');

        // Clear form
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        setState(() {
          _newPasswordTouched = false;
          _confirmPasswordTouched = false;
        });

        // Navigate to login after 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ToastHelper.showError(
            context,
            response.message ?? 'Failed to update password. Please try again.',
          );
        }
      }
    } on ApiException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
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
        setState(() => _isLoading = false);
      }
    }
  }

  // Navigate to login
  void _navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.passwordResetGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildResetCard(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildMemberNameField(),
                  const SizedBox(height: 24),
                  _buildNewPasswordField(),
                  const SizedBox(height: 24),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 32),
                  _buildResetButton(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppTheme.passwordResetButtonGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lock_reset, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Reset Password',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your new password',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            const Text(
              'Member Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF495057),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFE9ECEF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFDEE2E6)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.name ?? 'User',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewPasswordField() {
    final validationState = _getPasswordValidationState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lock, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            const Text(
              'New Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF495057),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _newPasswordController,
          focusNode: _newPasswordFocusNode,
          obscureText: _newPasswordObscured,
          enabled: !_isLoading,
          decoration: InputDecoration(
            hintText: 'Enter new password',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFF667eea),
                width: 2,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _newPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() => _newPasswordObscured = !_newPasswordObscured);
              },
            ),
          ),
          onTap: () {
            setState(() => _newPasswordTouched = true);
          },
        ),
        if (validationState != ValidationState.none)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildValidationMessage(validationState, true),
          ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    final validationState = _getConfirmPasswordValidationState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lock, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF495057),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordFocusNode,
          obscureText: _confirmPasswordObscured,
          enabled: !_isLoading,
          decoration: InputDecoration(
            hintText: 'Confirm new password',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE1E5E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: validationState == ValidationState.error
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFF667eea),
                width: 2,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _confirmPasswordObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(
                  () => _confirmPasswordObscured = !_confirmPasswordObscured,
                );
              },
            ),
          ),
          onTap: () {
            setState(() => _confirmPasswordTouched = true);
          },
        ),
        if (validationState != ValidationState.none)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildValidationMessage(validationState, false),
          ),
      ],
    );
  }

  Widget _buildValidationMessage(ValidationState state, bool isPasswordField) {
    IconData icon;
    Color color;
    String message;

    switch (state) {
      case ValidationState.error:
        icon = Icons.error;
        color = const Color(0xFFE74C3C);
        if (isPasswordField) {
          message = _newPasswordController.text.isEmpty
              ? 'Password is required'
              : 'Password must be at least 6 characters long';
        } else {
          message = _confirmPasswordController.text.isEmpty
              ? 'Please confirm your password'
              : 'Passwords do not match';
        }
        break;
      case ValidationState.info:
        icon = Icons.info;
        color = const Color(0xFF17A2B8);
        message =
            'Password length: ${_newPasswordController.text.length}/6 characters';
        break;
      case ValidationState.success:
        icon = Icons.check_circle;
        color = const Color(0xFF28A745);
        message = 'Password length is valid';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(message, style: TextStyle(fontSize: 13, color: color)),
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: _isFormValid && !_isLoading
            ? AppTheme.passwordResetButtonGradient
            : null,
        color: !_isFormValid || _isLoading ? const Color(0xFFDEE2E6) : null,
        borderRadius: BorderRadius.circular(8),
        boxShadow: _isFormValid && !_isLoading
            ? [
                BoxShadow(
                  color: const Color(0xFF667eea).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isFormValid && !_isLoading ? _handlePasswordReset : null,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _isFormValid && !_isLoading
                          ? Colors.white
                          : const Color(0xFF6C757D),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE9ECEF), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Remember your password? ',
            style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
          ),
          InkWell(
            onTap: _navigateToLogin,
            child: const Row(
              children: [
                Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667eea),
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.login, size: 16, color: Color(0xFF667eea)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Enum for validation states
enum ValidationState { none, error, info, success }
