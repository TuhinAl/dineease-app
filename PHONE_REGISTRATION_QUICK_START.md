# Phone Registration Screen - Quick Start Guide

## Prerequisites

1. **Backend Server Running**
   - Ensure your DineEase backend is running on `http://localhost:9000`
   - The following endpoints must be available:
     - `POST /dine-ease/api/v1/member/phone/number/already-registered-phone`
     - `POST /dine-ease/api/v1/member/phone/number/send-otp-code`

2. **Dependencies Installed**
   ```bash
   flutter pub get
   ```

3. **Code Generated**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## Testing the Screen

### 1. Navigate to Phone Registration Screen

Add the screen to your app's routing (if not already added):

```dart
// In your main.dart or router configuration
import 'package:trying_flutter/screens/auth/phone_registration_screen.dart';

MaterialApp(
  routes: {
    '/phone-registration': (context) => const PhoneRegistrationScreen(),
    // ... other routes
  },
)
```

Navigate to it from anywhere in your app:

```dart
Navigator.pushNamed(context, '/phone-registration');
// or
Navigator.pushNamed(context, AppRoutes.phoneRegistration);
```

### 2. Test Scenarios

#### Test Case 1: Valid New Phone Number
**Steps:**
1. Enter a phone number that is NOT registered: `01712345678`
2. Click "Verify Phone Number"

**Expected Result:**
- Loading spinner appears
- Button shows "Verifying..."
- Success toast: "OTP sent to 01712345678"
- Navigates to OTP Verification screen
- OTP screen receives phoneNumber and otpExpireTime

---

#### Test Case 2: Already Registered Phone Number
**Steps:**
1. Enter a phone number that IS already registered: `01726967760`
2. Click "Verify Phone Number"

**Expected Result:**
- Loading spinner appears briefly
- Inline error appears below input: "This phone number is already registered. Please try logging in."
- Error toast: "This phone number is already registered. Please login with your phone number."
- User stays on registration screen
- Can retry with different number

---

#### Test Case 3: Empty Phone Number
**Steps:**
1. Click "Verify Phone Number" without entering anything

**Expected Result:**
- Error toast: "Please enter a valid phone number."
- No API call is made
- User stays on screen

---

#### Test Case 4: Invalid Length (Less than 11 digits)
**Steps:**
1. Enter a phone number with less than 11 digits: `017123`
2. Click "Verify Phone Number"

**Expected Result:**
- Error toast: "Phone number must be at least 11 digits long."
- No API call is made
- User stays on screen

---

#### Test Case 5: Network Connection Error
**Steps:**
1. Stop your backend server
2. Enter a valid phone number: `01712345678`
3. Click "Verify Phone Number"

**Expected Result:**
- Loading spinner appears
- Error toast: "Unable to connect to server. Please check your internet connection or try again later."
- After 2 seconds, info toast: "Tap to retry when connection is restored"
- User stays on screen
- Form data preserved (can retry)

---

#### Test Case 6: Navigate to Login
**Steps:**
1. Click "Login here" link at the bottom

**Expected Result:**
- Navigates to login screen

---

### 3. UI/UX Testing

#### Focus State
- Click on phone input field
- **Expected**: Background turns white, border turns purple, subtle shadow appears

#### Input Validation
- Type only numbers
- **Expected**: Only digits 0-9 are accepted, max 11 characters

#### Responsive Design
- Resize browser window to mobile size (≤480px)
- **Expected**: Font sizes adjust, padding reduces, maintains usability

#### Button States
- Enter invalid data (e.g., 5 digits)
- **Expected**: Button appears disabled (lower opacity)
- Enter valid data (11 digits)
- **Expected**: Button becomes fully enabled

---

## API Response Examples

### 1. Check Phone - Already Registered (200 OK)
```json
{
  "data": {
    "phoneNumber": "01726967760",
    "id": "member-123",
    "isPhoneNumberAlreadyRegistered": "true"
  },
  "status": true,
  "message": "Phone number is already registered",
  "apiResponseCode": "SUCCESS",
  "httpStatusCode": 200
}
```

### 2. Check Phone - Not Registered (404 Not Found)
```json
{
  "data": null,
  "status": false,
  "message": "Member not found with this phone number",
  "apiResponseCode": "MEMBER_NOT_FOUND",
  "httpStatusCode": 404
}
```

### 3. Send OTP - Success (200 OK)
```json
{
  "data": {
    "id": "sms-789",
    "phoneNumber": "01712345678",
    "otp": "123456",
    "otpResponseBody": "OTP sent successfully",
    "expiryTime": "2025-12-02T15:45:00",
    "otpExpireTime": "2025-12-02T15:45:00",
    "attempts": 1,
    "isPhoneNumberAlreadyRegistered": "false"
  },
  "status": true,
  "message": "OTP sent successfully",
  "apiResponseCode": "SUCCESS",
  "httpStatusCode": 200
}
```

---

## Troubleshooting

### Issue: "Target of URI hasn't been generated" error
**Solution:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Toast not showing
**Solution:**
- Ensure your screen is wrapped in a MaterialApp
- Check that Scaffold widget exists in the widget tree

### Issue: Navigation not working
**Solution:**
- Verify AppRoutes.otpVerification is defined in constants.dart
- Check that route is registered in MaterialApp routes

### Issue: API call fails immediately
**Solution:**
- Verify backend server is running: `curl http://localhost:9000`
- Check API endpoints in lib/config/environment.dart
- Review network logs in Flutter DevTools

---

## Running the App

### Development Mode
```bash
# For web
flutter run -d chrome

# For mobile
flutter run -d <device-id>

# List available devices
flutter devices
```

### Hot Reload
After making changes:
- Press `r` in terminal for hot reload
- Press `R` for hot restart

---

## Expected Navigation Flow

```
Phone Registration Screen
         ↓
User enters phone: 01712345678
         ↓
Click "Verify Phone Number"
         ↓
    Loading...
         ↓
Check if registered?
    ↙         ↘
  Yes         No
   ↓           ↓
Show error  Send OTP
Stay here      ↓
          OTP sent!
              ↓
         Navigate to
    OTP Verification Screen
         (with args)
              ↓
    OTP Verification Screen
    receives:
    - phoneNumber: "01712345678"
    - otpExpireTime: "2025-12-02T15:45:00"
```

---

## Integration Notes

### If OTP Verification Screen Doesn't Exist Yet
Create a placeholder screen to test navigation:

```dart
// lib/screens/auth/otp_verification_screen.dart
class OTPVerificationScreen extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const OTPVerificationScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final args = arguments ?? 
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone: ${args['phoneNumber']}'),
            Text('Expiry: ${args['otpExpireTime']}'),
          ],
        ),
      ),
    );
  }
}
```

### Update Routes
```dart
// lib/config/constants.dart
class AppRoutes {
  static const String phoneRegistration = '/phone-registration';
  static const String otpVerification = '/otp-verification';
  static const String login = '/login';
  // ... other routes
}
```

---

## Checklist Before Testing

- [ ] Backend server is running on `http://localhost:9000`
- [ ] `flutter pub get` has been run
- [ ] `dart run build_runner build` has been run successfully
- [ ] Routes are configured in MaterialApp
- [ ] AppRoutes constants are defined
- [ ] No compilation errors in the project

---

## Success Criteria

✅ Screen loads without errors  
✅ Phone input accepts only 11 digits  
✅ Validation works for empty and short inputs  
✅ API calls execute successfully  
✅ Loading states display correctly  
✅ Error messages show for duplicate phone  
✅ Success toast appears on OTP send  
✅ Navigation to OTP screen works  
✅ Arguments passed correctly to OTP screen  
✅ "Login here" link navigates correctly  
✅ Responsive design works on mobile  
✅ No memory leaks (controllers disposed)  

---

## Next Steps

After testing the Phone Registration Screen:

1. **Implement OTP Verification Screen** (if not done)
2. **Implement Member Registration Screen** (after OTP verification)
3. **Test the complete registration flow end-to-end**
4. **Add analytics tracking** (optional)
5. **Perform security audit**
6. **Deploy to production**

---

## Support

If you encounter issues:
1. Check Flutter DevTools console for errors
2. Review API response in network tab
3. Verify environment configuration
4. Check the PHONE_REGISTRATION_IMPLEMENTATION.md for details

Happy Testing! 🚀
