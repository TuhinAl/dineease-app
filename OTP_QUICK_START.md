# OTP Component - Quick Start Guide

## 🚀 Quick Start

The OTP verification component is ready to use in your Flutter app. Choose one of the two options below:

---

## Option 1: Use the Complete OTP Screen (Recommended)

**Perfect for**: Phone number verification flow

### Usage

Navigate to the OTP verification screen:

```dart
Navigator.of(context).pushNamed(
  AppRoutes.otpVerification,
  arguments: {
    'phoneNumber': '1234567890',
    'otpExpireTime': '2024-12-02T10:30:00Z', // optional
  },
);
```

### What You Get

- ✅ Complete UI with purple gradient background
- ✅ 6-digit OTP input with auto-advance and backspace
- ✅ 5-minute countdown timer
- ✅ Resend OTP functionality
- ✅ Error handling with shake animation
- ✅ Toast notifications
- ✅ Automatic navigation to registration on success

### File Location
`lib/screens/auth/otp_verification_screen.dart`

---

## Option 2: Use the Reusable Widget

**Perfect for**: Custom screens, two-factor auth, email verification, etc.

### Step 1: Create Controllers

```dart
final List<TextEditingController> _controllers = 
    List.generate(6, (_) => TextEditingController());
final List<FocusNode> _focusNodes = 
    List.generate(6, (_) => FocusNode());
bool _hasError = false;
```

### Step 2: Add Widget to Your UI

```dart
OtpInputWidget(
  controllers: _controllers,
  focusNodes: _focusNodes,
  hasError: _hasError,
  onChanged: () {
    setState(() => _hasError = false);
  },
  onCompleted: (otp) {
    // Verify the OTP
    print('OTP entered: $otp');
    verifyOtp(otp);
  },
)
```

### Step 3: Clean Up

```dart
@override
void dispose() {
  for (var controller in _controllers) {
    controller.dispose();
  }
  for (var node in _focusNodes) {
    node.dispose();
  }
  super.dispose();
}
```

### File Location
`lib/widgets/otp_input_widget.dart`

---

## API Integration

### Verify OTP

```dart
import 'package:trying_flutter/services/auth_service.dart';
import 'package:trying_flutter/models/auth/otp_dtos.dart';

final authService = AuthService();

Future<void> verifyOtp(String otp) async {
  try {
    final request = VerifyOtpRequest(
      phoneNumber: phoneNumber,
      otp: otp,
    );
    
    final response = await authService.verifyOtp(request);
    
    if (response.status == true) {
      // Success!
      print('OTP verified');
    }
  } on ApiException catch (e) {
    // Handle error
    print('Error: ${e.message}');
  }
}
```

### Resend OTP

```dart
Future<void> resendOtp() async {
  try {
    final request = ResendOtpRequest(phoneNumber: phoneNumber);
    final response = await authService.resendOtp(request);
    
    if (response.status == true) {
      print('OTP resent successfully');
    }
  } on ApiException catch (e) {
    print('Error: ${e.message}');
  }
}
```

---

## Features

| Feature | Included |
|---------|----------|
| 6-digit numeric input | ✅ |
| Auto-advance on digit entry | ✅ |
| Backspace navigation | ✅ |
| Visual focus states | ✅ |
| Error states (red borders) | ✅ |
| Shake animation on error | ✅ |
| 5-minute countdown timer | ✅ (screen only) |
| Resend OTP | ✅ (screen only) |
| Toast notifications | ✅ (screen only) |
| Responsive design | ✅ |
| Purple gradient theme | ✅ (screen only) |

---

## Common Patterns

### Pattern 1: Verify on Button Click

```dart
ElevatedButton(
  onPressed: () {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      verifyOtp(otp);
    }
  },
  child: const Text('Verify'),
)
```

### Pattern 2: Auto-Verify on Completion

```dart
OtpInputWidget(
  controllers: _controllers,
  focusNodes: _focusNodes,
  onCompleted: (otp) {
    // Automatically verify when all digits entered
    verifyOtp(otp);
  },
)
```

### Pattern 3: Show Error State

```dart
// After failed verification
setState(() {
  _hasError = true;
});

// Clear all fields
for (var controller in _controllers) {
  controller.clear();
}

// Focus first field
_focusNodes[0].requestFocus();
```

---

## Troubleshooting

### Issue: Fields not accepting input
**Solution**: Make sure you've created 6 controllers and 6 focus nodes

### Issue: Backspace not working
**Solution**: Backspace requires physical keyboard. On mobile, it clears current field automatically

### Issue: Auto-focus not working
**Solution**: Use `WidgetsBinding.instance.addPostFrameCallback` in `initState()`

### Issue: Error state not clearing
**Solution**: Call `setState(() => _hasError = false)` in the `onChanged` callback

---

## Next Steps

1. **Test the implementation**: Run `flutter run` and navigate to the OTP screen
2. **Customize styling**: Modify colors, sizes, or fonts as needed
3. **Add features**: Consider implementing SMS autofill or biometric verification
4. **Read full documentation**: See `OTP_COMPONENT_IMPLEMENTATION.md` for detailed info

---

## Support

For detailed documentation, see:
- **Full Documentation**: `OTP_COMPONENT_IMPLEMENTATION.md`
- **Implementation Summary**: `OTP_IMPLEMENTATION_SUMMARY.md`
- **API Reference**: `API_REFERENCE.md`

---

## Example: Complete Custom Screen

```dart
import 'package:flutter/material.dart';
import 'package:trying_flutter/widgets/otp_input_widget.dart';

class MyOtpScreen extends StatefulWidget {
  const MyOtpScreen({super.key});

  @override
  State<MyOtpScreen> createState() => _MyOtpScreenState();
}

class _MyOtpScreenState extends State<MyOtpScreen> {
  final List<TextEditingController> _controllers = 
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = 
      List.generate(6, (_) => FocusNode());
  bool _hasError = false;

  @override
  void dispose() {
    for (var controller in _controllers) controller.dispose();
    for (var node in _focusNodes) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Verification Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            OtpInputWidget(
              controllers: _controllers,
              focusNodes: _focusNodes,
              hasError: _hasError,
              onChanged: () => setState(() => _hasError = false),
              onCompleted: (otp) {
                print('OTP: $otp');
                // Verify here
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

**That's it!** 🎉 Your OTP component is ready to use.
