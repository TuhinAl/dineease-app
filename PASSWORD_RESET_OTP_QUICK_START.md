# Password Reset OTP Verification - Quick Start Guide

## 🚀 Quick Integration

### 1. Add the Route

In your app's route configuration:

```dart
// main.dart or routes.dart
import 'package:trying_flutter/screens/auth/password_reset_otp_verification_screen.dart';

// Add to routes map
routes: {
  '/password-reset-otp': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return PasswordResetOTPVerificationScreen(
      phoneNumber: args?['phoneNumber'],
      otpExpireTime: args?['otpExpireTime'],
    );
  },
}

// OR add to AppRoutes constants
class AppRoutes {
  static const String passwordResetOtp = '/password-reset-otp';
}
```

### 2. Navigate to the Screen

From your "Forgot Password" screen after sending OTP:

```dart
// After successfully sending OTP
Navigator.pushNamed(
  context,
  '/password-reset-otp',
  arguments: {
    'phoneNumber': '01712345678',          // Required
    'otpExpireTime': '2024-12-02T10:30:00', // Optional (uses 5 min default if not provided)
  },
);
```

### 3. Handle Navigation Back

The screen automatically navigates to password reset on success:

```dart
// Add password reset route
routes: {
  '/password-reset': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return PasswordResetScreen(
      phoneNumber: args?['phoneNumber'],
      name: args?['name'],
    );
  },
}
```

## 📋 Complete Flow Example

```dart
// 1. User enters phone number on "Forgot Password" screen
class ForgotPasswordScreen extends StatelessWidget {
  Future<void> _sendOTP(String phoneNumber) async {
    // Call your send OTP API
    final response = await authService.sendPasswordResetOTP(phoneNumber);
    
    if (response.success) {
      // Navigate to OTP verification
      Navigator.pushNamed(
        context,
        '/password-reset-otp',
        arguments: {
          'phoneNumber': phoneNumber,
          'otpExpireTime': response.data?.otpExpireTime,
        },
      );
    }
  }
}

// 2. User verifies OTP (automatic navigation on success)
// PasswordResetOTPVerificationScreen handles this

// 3. User resets password
class PasswordResetScreen extends StatelessWidget {
  final String phoneNumber;
  final String name;
  
  Future<void> _resetPassword(String newPassword) async {
    // Call your password reset API
    final response = await authService.resetPassword(
      phoneNumber: phoneNumber,
      newPassword: newPassword,
    );
    
    if (response.success) {
      // Navigate to login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
```

## 🔧 Configuration

### Required Constants

Already defined in `lib/config/constants.dart`:

```dart
class StorageKeys {
  static const String phoneNumber = 'phoneNumber';
  static const String otpExpiryTimestamp = 'otp_expiry_timestamp';
  static const String otpPhoneNumber = 'otp_phone_number';
}

class AppRoutes {
  static const String passwordReset = '/password-reset';
}
```

### Required API Endpoints

Already defined in `lib/config/environment.dart`:

```dart
class ApiEndpoints {
  static const String otpVerification =
      '${Environment.contextPath}/member/phone/number/verify-otp';
  static const String resendOtp =
      '${Environment.contextPath}/member/phone/number/re-send-otp-code';
}
```

### Required Services

Already implemented in `lib/services/auth_service.dart`:

```dart
// Verify OTP for password reset
Future<ApiResponse<MemberInfoDto>> verifyPasswordResetOtp(SMSDto request);

// Resend OTP for password reset
Future<ApiResponse<MemberInfoDto>> resendPasswordResetOtp(SMSDto request);
```

## 📱 User Experience Flow

1. **User arrives at screen** → Timer starts automatically (or resumes if returning)
2. **User enters 6 digits** → Progress indicator shows "X/6 digits entered"
3. **All 6 digits entered** → Verify button becomes enabled
4. **User taps Verify** → API call validates OTP
5. **Success** → Navigate to password reset screen
6. **Error** → Show error message, shake animation, keep OTP visible for correction
7. **Timer expires** → Show "Resend OTP" button
8. **User taps Resend** → Clear fields, restart timer, auto-focus first field

## ⚙️ Key Features

### ✅ Persistent Timer
- Survives app backgrounding
- Resumes from exact timestamp
- Uses server-provided expiry if available
- Falls back to 5-minute default

### ✅ Smart Input
- Auto-advance to next field
- Backspace moves to previous field
- Numeric-only validation
- Auto-submit when 6 digits entered

### ✅ Progress Tracking
- Shows "X/6 digits entered" badge
- Only visible when 1-5 digits filled
- Purple gradient styling

### ✅ Timer Warnings
- "Expires in X minutes" when > 60s
- "Expires in X seconds" when ≤ 60s
- ⚠️ "Please complete verification soon" warning when ≤ 60s
- Red "OTP has expired" section when timer reaches 0

### ✅ Error Handling
- Invalid OTP → Shake animation + error message + keep values
- Expired OTP → Show expiry message + resend button
- Network error → Generic error message
- All errors shown as toast notifications

### ✅ Page Protection
- Warns user when trying to leave during verification
- Shows confirmation dialog
- Skips warning after successful verification
- Skips warning if timer already expired

## 🎨 Customization

### Change Timer Duration

```dart
// In password_reset_otp_verification_screen.dart
// Change from 300 seconds (5 minutes) to desired duration

// Line ~134
expiryTime = now.add(const Duration(seconds: 300)); // Change this

// Line ~390 (resend OTP)
DateTime newExpiry = now.add(const Duration(seconds: 300)); // Change this
```

### Change Colors

```dart
// Purple gradient (default)
const primaryGradient = LinearGradient(
  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
);

// To customize, replace in:
// - Header background (line ~470)
// - Phone number gradient (line ~495)
// - Timer text gradient (line ~716)
// - Progress indicator gradient (line ~782)
```

### Change Input Field Styling

```dart
// In _buildOtpDigitField method (line ~613)
double fieldWidth = 60;   // Width of each input
double fieldHeight = 70;  // Height of each input
double fontSize = 24;     // Font size of digit
double gap = 12;          // Gap between fields
```

## 🧪 Testing

### Manual Testing Checklist

```dart
// 1. Timer Persistence
// - Start verification
// - Navigate away (press back)
// - Return to screen
// ✓ Timer should resume from correct time

// 2. Input Validation
// - Try entering letters → Should reject
// - Try entering symbols → Should reject
// - Enter 6 digits → Should enable verify button
// ✓ Only numeric digits accepted

// 3. OTP Verification
// - Enter valid OTP → Should navigate to password reset
// - Enter invalid OTP → Should show error + shake
// - Wait for expiry → Should disable verify button
// ✓ All scenarios handled correctly

// 4. Resend OTP
// - Wait for timer to expire
// - Tap "Resend OTP"
// ✓ Should clear fields, restart timer, send new OTP

// 5. Page Protection
// - Start verification (timer > 0)
// - Press back button
// ✓ Should show confirmation dialog

// - Complete verification
// - Press back button
// ✓ Should NOT show dialog (goes back immediately)
```

### Automated Testing Example

```dart
// test/screens/password_reset_otp_test.dart
testWidgets('OTP input auto-advances on digit entry', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: PasswordResetOTPVerificationScreen(
        phoneNumber: '01712345678',
      ),
    ),
  );
  
  // Find first input field
  final firstField = find.byType(TextField).first;
  
  // Enter digit
  await tester.enterText(firstField, '1');
  await tester.pump();
  
  // Verify focus moved to second field
  final secondField = find.byType(TextField).at(1);
  expect(tester.widget<TextField>(secondField).focusNode?.hasFocus, isTrue);
});
```

## 🐛 Common Issues & Solutions

### Issue: "Phone number not found" error
**Solution:** Ensure phone number is either:
1. Passed via navigation arguments, OR
2. Stored in SharedPreferences with key `'phoneNumber'`

```dart
// Store phone number before navigation
final prefs = await SharedPreferences.getInstance();
await prefs.setString('phoneNumber', '01712345678');
```

### Issue: Timer doesn't persist
**Solution:** Check that timer storage is working:

```dart
// Debug: Check stored values
final prefs = await SharedPreferences.getInstance();
print('Stored timestamp: ${prefs.getInt('otp_expiry_timestamp')}');
print('Stored phone: ${prefs.getString('otp_phone_number')}');
```

### Issue: Verify button always disabled
**Solution:** Ensure timer is running and not expired:

```dart
// Check conditions:
// 1. All 6 digits filled: _controllers.every((c) => c.text.isNotEmpty)
// 2. Timer not expired: _timeLeft > 0
// 3. Not loading: !_isLoading
```

### Issue: Navigation doesn't work
**Solution:** Ensure password reset route exists:

```dart
// Add to routes
routes: {
  '/password-reset': (context) => PasswordResetScreen(...),
}

// Or use named route
class AppRoutes {
  static const String passwordReset = '/password-reset';
}
```

## 📦 Dependencies Required

Already included in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.0  # Timer persistence
  dio: ^5.0.0                  # API calls
```

## 🎯 Next Steps

After integrating the OTP verification screen:

1. **Create Password Reset Screen**
   - Receives `phoneNumber` and `name` from arguments
   - Allows user to enter new password
   - Validates password strength
   - Calls password update API

2. **Test Complete Flow**
   - Forgot Password → Send OTP → Verify OTP → Reset Password → Login

3. **Add Analytics** (Optional)
   - Track OTP verification success rate
   - Monitor time taken to verify
   - Track resend OTP frequency

4. **Enhance UX** (Optional)
   - Add SMS auto-read (Android)
   - Support copy-paste of full OTP
   - Add haptic feedback on error

## 📝 Example: Complete Integration

```dart
// main.dart
import 'package:flutter/material.dart';
import 'screens/auth/password_reset_otp_verification_screen.dart';
import 'screens/auth/password_reset_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/password-reset-otp': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map?;
          return PasswordResetOTPVerificationScreen(
            phoneNumber: args?['phoneNumber'],
            otpExpireTime: args?['otpExpireTime'],
          );
        },
        '/password-reset': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map?;
          return PasswordResetScreen(
            phoneNumber: args?['phoneNumber'],
            name: args?['name'],
          );
        },
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
```

---

## 🎉 You're Ready!

The Password Reset OTP Verification screen is now integrated and ready to use. 

For detailed implementation information, see: `PASSWORD_RESET_OTP_IMPLEMENTATION.md`

For any issues or questions, refer to the troubleshooting section above or check the comprehensive implementation guide.
