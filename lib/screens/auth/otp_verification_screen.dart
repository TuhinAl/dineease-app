import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import '../../config/app_theme.dart';
import '../../config/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/loading_indicator.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  int _timeLeft = 300; // 5 minutes in seconds
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> _verifyOTP(String otp) async {
    if (otp.length != 6) {
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);

      ToastHelper.showSuccess(context, "OTP verified successfully!");

      // Navigate to member registration
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.memberRegistration,
        arguments: widget.phoneNumber,
      );
    }
  }

  Future<void> _resendOTP() async {
    if (!_canResend) return;

    setState(() {
      _isLoading = true;
      _canResend = false;
      _timeLeft = 300;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      _startTimer();

      ToastHelper.showSuccess(context, "OTP resent to ${widget.phoneNumber}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified_user,
                      size: 60,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Verify OTP',
                  style: AppTextStyles.headingMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 6-digit code sent to',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '+88 ${widget.phoneNumber}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // OTP Input
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeFillColor: AppTheme.surfaceColor,
                    inactiveFillColor: AppTheme.surfaceColor,
                    selectedFillColor: AppTheme.primaryColor.withOpacity(0.1),
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: AppTheme.borderColor,
                    selectedColor: AppTheme.primaryColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: _verifyOTP,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 24),

                // Timer
                if (!_canResend)
                  Text(
                    'Time remaining: ${DateTimeHelper.formatTimeDuration(_timeLeft)}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                // Resend Button
                if (_canResend)
                  TextButton(
                    onPressed: _isLoading ? null : _resendOTP,
                    child: Text(
                      'Resend OTP',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // Verify Button
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () => _verifyOTP(_otpController.text),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? const SmallLoadingIndicator(color: Colors.white)
                      : const Text(
                          'Verify OTP',
                          style: AppTextStyles.buttonText,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
