import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable OTP input widget with 6 digit fields
///
/// Features:
/// - Auto-advance on digit entry
/// - Backspace navigation to previous field
/// - Visual error state with shake animation
/// - Responsive sizing for different screen sizes
/// - Focus management
///
/// Usage:
/// ```dart
/// OtpInputWidget(
///   controllers: _controllers,
///   focusNodes: _focusNodes,
///   hasError: _otpError,
///   onChanged: () {
///     setState(() {
///       _otpError = false;
///     });
///   },
///   onCompleted: (otp) {
///     _verifyOTP(otp);
///   },
/// )
/// ```
class OtpInputWidget extends StatefulWidget {
  /// List of 6 TextEditingControllers for each digit
  final List<TextEditingController> controllers;

  /// List of 6 FocusNodes for each digit
  final List<FocusNode> focusNodes;

  /// Whether to show error state (red borders)
  final bool hasError;

  /// Callback when any digit changes
  final VoidCallback? onChanged;

  /// Callback when all 6 digits are filled
  final Function(String otp)? onCompleted;

  /// Enable shake animation on error
  final bool enableShakeAnimation;

  const OtpInputWidget({
    super.key,
    required this.controllers,
    required this.focusNodes,
    this.hasError = false,
    this.onChanged,
    this.onCompleted,
    this.enableShakeAnimation = true,
  }) : assert(controllers.length == 6, 'Must provide exactly 6 controllers'),
       assert(focusNodes.length == 6, 'Must provide exactly 6 focus nodes');

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _previousErrorState = false;

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
  }

  @override
  void didUpdateWidget(OtpInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger shake animation when error state changes to true
    if (widget.enableShakeAnimation &&
        widget.hasError &&
        !_previousErrorState) {
      _shakeController.forward().then((_) => _shakeController.reverse());
    }
    _previousErrorState = widget.hasError;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    // Notify parent of change
    widget.onChanged?.call();

    // Validate numeric input
    if (value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value)) {
      widget.controllers[index].clear();
      return;
    }

    // Auto-focus next field
    if (value.isNotEmpty && index < 5) {
      widget.focusNodes[index + 1].requestFocus();

      // Check if all fields are filled
      _checkCompletion();
    } else if (value.isNotEmpty && index == 5) {
      // Last field filled, check completion
      _checkCompletion();
    }
  }

  void _checkCompletion() {
    final allFilled = widget.controllers.every((c) => c.text.isNotEmpty);
    if (allFilled) {
      final otp = widget.controllers.map((c) => c.text).join();
      widget.onCompleted?.call(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.hasError && widget.enableShakeAnimation
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 400;
    final isMobile = screenWidth <= 600;

    // Responsive sizing
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
            if (widget.controllers[index].text.isEmpty && index > 0) {
              widget.focusNodes[index - 1].requestFocus();
              // Clear the previous field
              widget.controllers[index - 1].clear();
            }
          }
        },
        child: TextField(
          controller: widget.controllers[index],
          focusNode: widget.focusNodes[index],
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
            fillColor: widget.focusNodes[index].hasFocus
                ? Colors.white
                : const Color(0xFFf8fafc),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.hasError
                    ? const Color(0xFFef4444)
                    : const Color(0xFFe2e8f0),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.hasError
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
            // Trigger rebuild to update focus state
            if (mounted) {
              setState(() {});
            }
          },
          onEditingComplete: () {
            if (index < 5) {
              widget.focusNodes[index + 1].requestFocus();
            }
          },
          onSubmitted: (value) {
            if (index == 5) {
              _checkCompletion();
            }
          },
          onTapOutside: (_) {
            // Trigger rebuild to update focus state
            if (mounted) {
              setState(() {});
            }
          },
        ),
      ),
    );
  }
}
