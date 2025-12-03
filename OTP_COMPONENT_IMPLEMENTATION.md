# OTP Verification Component Implementation

## Overview

The OTP (One-Time Password) verification component allows users to verify their phone number using a 6-digit numeric code. This implementation includes both a complete screen and a reusable widget component.

## Files

### 1. OTP Verification Screen
**Location**: `lib/screens/auth/otp_verification_screen.dart`

A complete Flutter screen that handles the entire OTP verification flow.

### 2. OTP Input Widget (Reusable Component)
**Location**: `lib/widgets/otp_input_widget.dart`

A standalone, reusable widget for OTP input fields that can be used anywhere in the app.

## Features

### Core Functionality
- ✅ **6-digit OTP input** with individual numeric fields
- ✅ **Auto-advance** - automatically moves to next field when a digit is entered
- ✅ **Backspace navigation** - moves to previous field when backspace is pressed in empty field
- ✅ **5-minute countdown timer** with MM:SS format display
- ✅ **Resend OTP** functionality with timer reset
- ✅ **Visual error states** with red borders and inline error messages
- ✅ **Shake animation** on invalid OTP entry
- ✅ **Toast notifications** for success/error feedback
- ✅ **Responsive design** - adapts to different screen sizes
- ✅ **Purple gradient background** matching design requirements

### Input Behavior
- Only accepts numeric digits (0-9)
- Single character per field
- Auto-focus management
- Clear error state on typing
- Visual focus indicators
- Automatic OTP submission when all fields are filled

### Timer Behavior
- Starts at 5 minutes (300 seconds) when screen opens
- Displays remaining time in MM:SS format
- Shows "OTP has expired" message when timer reaches 0
- Provides resend button when expired
- Resets timer to 5 minutes on resend

## API Integration

### Verify OTP Endpoint
**URL**: `POST /dine-ease/api/v1/member/phone/number/verify-otp`

**Request Body**:
```json
{
  "phoneNumber": "1234567890",
  "otp": "123456",
  "expiryTime": "2024-12-02T10:30:00Z" // optional
}
```

**Success Response**:
```json
{
  "status": true,
  "message": "OTP verified successfully",
  "data": {
    "isAdmin": false
  }
}
```

### Resend OTP Endpoint
**URL**: `POST /dine-ease/api/v1/member/phone/number/re-send-otp-code`

**Request Body**:
```json
{
  "phoneNumber": "1234567890"
}
```

**Success Response**:
```json
{
  "status": true,
  "message": "OTP resent successfully",
  "data": {
    "expiryTime": "2024-12-02T10:35:00Z",
    "otpExpireTime": "2024-12-02T10:35:00Z"
  }
}
```

## Usage

### Using the Complete OTP Screen

Navigate to the screen with required parameters:

```dart
Navigator.of(context).pushNamed(
  AppRoutes.otpVerification,
  arguments: {
    'phoneNumber': '1234567890',
    'otpExpireTime': '2024-12-02T10:30:00Z', // optional
  },
);
```

### Using the Reusable OTP Input Widget

```dart
import 'package:trying_flutter/widgets/otp_input_widget.dart';

class MyCustomScreen extends StatefulWidget {
  @override
  State<MyCustomScreen> createState() => _MyCustomScreenState();
}

class _MyCustomScreenState extends State<MyCustomScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _hasError = false;

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

  void _handleOtpCompleted(String otp) {
    // Called when all 6 digits are entered
    print('OTP entered: $otp');
    // Verify the OTP
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OtpInputWidget(
                controllers: _controllers,
                focusNodes: _focusNodes,
                hasError: _hasError,
                onChanged: () {
                  // Called when any digit changes
                  setState(() {
                    _hasError = false;
                  });
                },
                onCompleted: _handleOtpCompleted,
                enableShakeAnimation: true,
              ),
              const SizedBox(height: 20),
              if (_hasError)
                const Text(
                  'Invalid OTP. Please try again.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Widget API Reference

### OtpInputWidget

#### Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `controllers` | `List<TextEditingController>` | Yes | - | List of 6 controllers for each digit field |
| `focusNodes` | `List<FocusNode>` | Yes | - | List of 6 focus nodes for each digit field |
| `hasError` | `bool` | No | `false` | Whether to show error state (red borders) |
| `onChanged` | `VoidCallback?` | No | `null` | Called when any digit changes |
| `onCompleted` | `Function(String otp)?` | No | `null` | Called when all 6 digits are filled |
| `enableShakeAnimation` | `bool` | No | `true` | Enable shake animation on error |

#### Example with Error Handling

```dart
OtpInputWidget(
  controllers: _controllers,
  focusNodes: _focusNodes,
  hasError: _otpError,
  onChanged: () {
    setState(() {
      _otpError = false; // Clear error when user types
    });
  },
  onCompleted: (otp) async {
    // Verify OTP
    final isValid = await verifyOtp(otp);
    if (!isValid) {
      setState(() {
        _otpError = true; // Show error state
      });
    }
  },
)
```

## Screen Flow

1. **Screen Opens**
   - Receives `phoneNumber` (required) and `otpExpireTime` (optional)
   - Starts 5-minute countdown timer
   - Auto-focuses first input field
   - Displays phone number to user

2. **User Enters OTP**
   - Types digits 0-9 only
   - Auto-advances to next field
   - Backspace moves to previous field
   - Error state clears on typing

3. **Verification**
   - User clicks "Verify OTP" button OR completes last digit
   - Shows loading indicator
   - Calls verify API
   - On success: navigates to member registration
   - On failure: shows error message and shake animation

4. **Timer Expiration**
   - Timer reaches 0
   - Shows "OTP has expired" message
   - Displays red "Resend OTP" button

5. **Resend OTP**
   - Clears all input fields
   - Calls resend API
   - Resets timer to 5 minutes
   - Updates expiry time
   - Shows success toast
   - Auto-focuses first field

## Navigation

After successful OTP verification, the screen navigates to:

```dart
Navigator.of(context).pushReplacementNamed(
  AppRoutes.memberRegistration,
  arguments: {
    'phoneNumber': widget.phoneNumber,
    'adminFlag': response.data?.isAdmin ?? false,
  },
);
```

## Error Handling

### Invalid OTP
- Shows inline error message in red box
- Triggers shake animation
- Displays toast: "Verification failed - [error message]"

### Expired OTP
- Shows inline error message
- Displays toast: "Please try again. OTP has Expired."
- Changes timer section to show resend button

### Network Errors
- Shows toast with error message
- Maintains current state
- Allows retry

## Responsive Design

The component adapts to different screen sizes:

| Screen Width | Field Size | Font Size | Gap |
|--------------|------------|-----------|-----|
| ≤ 400px | 45×55 | 18px | 6px |
| ≤ 600px | 50×60 | 20px | 8px |
| > 600px | 60×70 | 24px | 12px |

## Styling

### Colors
- **Primary Purple**: `#667eea`
- **Secondary Purple**: `#764ba2`
- **Error Red**: `#ef4444`
- **Border Gray**: `#e2e8f0`
- **Background**: `#f8fafc`
- **Text Gray**: `#64748b`

### Gradient
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
)
```

## Testing

To test the implementation:

1. **Manual Testing**:
   - Navigate to phone registration screen
   - Enter a valid phone number
   - You'll be redirected to OTP screen
   - Test input behavior, timer, resend, and verification

2. **Unit Testing** (future enhancement):
   ```dart
   testWidgets('OTP input accepts only digits', (tester) async {
     // Test implementation
   });
   
   testWidgets('Backspace navigates to previous field', (tester) async {
     // Test implementation
   });
   ```

## Dependencies

All required dependencies are already included in `pubspec.yaml`:
- `flutter/material.dart` - UI components
- `flutter/services.dart` - Input formatting and keyboard handling
- `dart:async` - Timer functionality

## Future Enhancements

Potential improvements:
- [ ] Paste OTP from clipboard
- [ ] Auto-read OTP from SMS
- [ ] Biometric verification option
- [ ] Different OTP lengths (4, 5, 6, 8 digits)
- [ ] Customizable colors and styling
- [ ] Accessibility improvements (screen reader support)
- [ ] Unit and widget tests

## Troubleshooting

### OTP fields not focusing properly
- Ensure all 6 FocusNodes are properly initialized
- Check that `WidgetsBinding.instance.addPostFrameCallback` is used for initial focus

### Timer not stopping
- Verify timer is cancelled in `dispose()` method
- Check `mounted` check before `setState()`

### Shake animation not working
- Ensure `SingleTickerProviderStateMixin` is included
- Verify `enableShakeAnimation` is set to `true`

### Backspace not working
- KeyboardListener requires physical keyboard (may not work on some mobile keyboards)
- Alternative: handle in `onChanged` callback

## Support

For issues or questions, refer to:
- Main documentation: `README.md`
- API documentation: `API_REFERENCE.md`
- Quick start guide: `QUICK_START.md`
