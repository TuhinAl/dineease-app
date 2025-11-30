# Login Screen - Quick Start Guide

## Prerequisites
- Flutter SDK installed (3.10.1 or higher)
- Backend server running on `http://localhost:9000`
- Android Studio / VS Code with Flutter extensions
- Android emulator or iOS simulator (or physical device)

## Installation Steps

### 1. Navigate to Project Directory
```bash
cd e:\study_station\flutter_experimenting\flutter_apps\trying_flutter\trying_flutter
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Verify Installation
```bash
flutter doctor
```
Ensure all checkmarks are green (at least one platform should be available).

## Running the Application

### Option 1: Using Flutter Command
```bash
flutter run
```
This will:
- Build the app
- Launch on connected device/emulator
- Enable hot reload for development

### Option 2: Using VS Code
1. Open the project in VS Code
2. Press `F5` or click "Run > Start Debugging"
3. Select target device from bottom right

### Option 3: Using Android Studio
1. Open the project in Android Studio
2. Select target device from device dropdown
3. Click the green play button

## Testing the Login Screen

### Pre-filled Credentials (Development Only)
The login screen comes with pre-filled credentials for testing:
- **Phone Number:** 01726967760
- **Password:** tuhin123

**⚠️ IMPORTANT:** These credentials are for development only and must be removed before production!

### Manual Testing Scenarios

#### 1. Successful Login
1. Launch the app
2. Credentials should be pre-filled
3. Click "Login" button
4. Should show loading spinner with "Signing in..." text
5. After successful authentication, should navigate to home screen

#### 2. Empty Form Validation
1. Clear both phone and password fields
2. Click "Login" button
3. Should show error messages:
   - "Phone number is required"
   - "Password is required"

#### 3. Invalid Phone Number
1. Enter phone number: "123"
2. Enter password: "tuhin123"
3. Click "Login" button
4. Should show: "Please enter a valid 11-digit phone number"

#### 4. Short Password
1. Enter phone number: "01726967760"
2. Enter password: "12345"
3. Click "Login" button
4. Should show: "Password must be at least 6 characters long"

#### 5. Invalid Credentials (Backend Required)
1. Enter phone number: "01726967760"
2. Enter password: "wrongpassword"
3. Click "Login" button
4. Should show global error alert: "Invalid phone number or password. Please try again."

#### 6. User Not Found (Backend Required)
1. Enter phone number: "01111111111"
2. Enter password: "password123"
3. Click "Login" button
4. Should show: "User not found. Please check your phone number or sign up."

#### 7. Network Error
1. Disconnect internet/turn off backend server
2. Enter valid credentials
3. Click "Login" button
4. Should show: "Network error. Please check your connection and try again."

## Backend API Requirements

### Login Endpoint
```
POST http://localhost:9000/dine-ease/api/v1/member/secure/login
Content-Type: application/json

Request Body:
{
  "phoneNumber": "01726967760",
  "password": "tuhin123"
}

Success Response (200):
{
  "status": true,
  "message": "Login successful",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1...",
    "refreshToken": "eyJhbGciOiJIUzI1...",
    "memberResponse": {
      "id": "uuid-string",
      "phoneNumber": "01726967760",
      "name": "John Doe",
      "email": "john@example.com",
      "roles": ["ROLE_USER"]
    }
  },
  "httpStatusCode": 200,
  "apiResponseCode": "SUCCESS"
}
```

### Dine Info Endpoint
```
POST http://localhost:9000/dine-ease/api/v1/dine/member-associate
Content-Type: application/json

Request Body:
{
  "phoneNumber": "01726967760"
}

Success Response (200):
{
  "status": true,
  "data": {
    "id": "dine-uuid",
    "dineName": "My Mess",
    "createdDate": "2024-01-01T00:00:00Z"
  }
}
```

## Troubleshooting

### Issue: "Target of URI doesn't exist" errors
**Solution:** Run `flutter pub get` to install dependencies

### Issue: App won't build
**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: "Waiting for another flutter command to release the startup lock"
**Solution:**
```bash
# Delete lock file
rm $HOME/.flutter/.dart_tool/.lock  # Mac/Linux
del %USERPROFILE%\.flutter\.dart_tool\.lock  # Windows PowerShell
```

### Issue: Network error during login
**Solutions:**
1. Ensure backend server is running on `http://localhost:9000`
2. Check if API endpoints are accessible:
   ```bash
   curl http://localhost:9000/dine-ease/api/v1/member/secure/login
   ```
3. For Android emulator, use `10.0.2.2` instead of `localhost`:
   - Edit `lib/config/environment.dart`
   - Change: `memberAuthService = 'http://10.0.2.2:9000'`

### Issue: iOS build fails
**Solution:**
```bash
cd ios
pod install
cd ..
flutter run
```

### Issue: Android build fails
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter run
```

## Hot Reload During Development

### Using Terminal
Press `r` in the terminal where `flutter run` is active

### Using VS Code
Press `Ctrl+S` (Windows/Linux) or `Cmd+S` (Mac) after saving changes

### Using Android Studio
Press `Ctrl+\` (Windows/Linux) or `Cmd+\` (Mac)

## Debugging

### Enable Debug Mode
App is in debug mode by default when using `flutter run`

### View Logs
```bash
flutter logs
```

### Debug in VS Code
1. Set breakpoints in code
2. Press `F5` to start debugging
3. Use debug toolbar to step through code

### Debug in Android Studio
1. Set breakpoints by clicking left margin
2. Click debug icon (bug icon)
3. Use debug toolbar

## Building for Production

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS
```bash
flutter build ios --release
```

**⚠️ Before Production Build:**
1. Remove pre-filled credentials from `lib/screens/auth/login_screen.dart` (lines 47-48)
2. Update API base URL in `lib/config/environment.dart`
3. Set `Environment.production = true`
4. Test thoroughly

## File Locations

### Important Files Modified/Created:
- `lib/config/environment.dart` - API configuration
- `lib/models/auth/auth_dtos.dart` - Data models
- `lib/services/auth_service.dart` - API service
- `lib/services/storage_service.dart` - Storage service
- `lib/screens/auth/login_screen.dart` - Login UI
- `lib/main.dart` - App initialization
- `pubspec.yaml` - Dependencies

### Storage Locations:
- **Secure Storage:** Platform-specific (Keychain on iOS, Keystore on Android)
- **Shared Preferences:** Platform-specific local storage

## Environment Configuration

### Development (Current)
```dart
// lib/config/environment.dart
static const bool production = false;
static const String memberAuthService = 'http://localhost:9000';
```

### Production (Update Before Release)
```dart
// lib/config/environment.dart
static const bool production = true;
static const String memberAuthService = 'https://api.yourserver.com';
```

## Next Steps After Login

After successful login, the app:
1. Saves access token to secure storage
2. Saves refresh token to secure storage
3. Saves user data (name, phone, ID)
4. Fetches and saves dine information
5. Navigates to home screen (`/home`)

## Support

For issues or questions:
1. Check `LOGIN_IMPLEMENTATION.md` for detailed documentation
2. Review Flutter documentation: https://flutter.dev/docs
3. Check project's existing screens for reference patterns

## Summary

The login screen is fully functional and ready to use. Simply:
1. Run `flutter pub get`
2. Start the backend server
3. Run `flutter run`
4. Test with pre-filled credentials

The app will automatically navigate to the home screen after successful login.
