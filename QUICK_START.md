# DineEase - Quick Start Guide

## 🚀 Quick Setup (5 minutes)

### 1. Prerequisites Check
```bash
flutter --version  # Should be 3.10.1 or higher
dart --version
```

### 2. Install Dependencies
```bash
cd trying_flutter
flutter pub get
```

### 3. Run the App
```bash
# On Android emulator/device
flutter run

# On specific device
flutter devices
flutter run -d <device-id>

# On Chrome (for web testing)
flutter run -d chrome
```

## 📱 Test the App

### Login Credentials (Mock)
Any valid 11-digit phone number and password (min 8 chars) will work.

**Example:**
- Phone: `01712345678`
- Password: `password123`

### Testing Registration Flow
1. Tap "Sign Up" on login screen
2. Enter any 11-digit number
3. Tap "Send OTP"
4. Enter any 6-digit code (e.g., `123456`)
5. Fill registration form
6. Accept terms and register

## 🎨 Customizing the App

### Change App Name
Edit `lib/main.dart`:
```dart
title: 'DineEase',  // Change to your app name
```

### Change Colors
Edit `lib/config/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF2196F3);  // Your color
static const Color appBarColor = Color(0xFF0a3e03);   // Your color
```

### Toggle Dark Mode
Edit `lib/main.dart`:
```dart
themeMode: ThemeMode.light,  // or .dark or .system
```

## 🔌 Connecting to Your Backend

### 1. Update Base URL
Create `lib/services/api_service.dart`:
```dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://your-api-url.com/api',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  // Add interceptors for auth tokens
  ApiService() {
    _dio.interceptors.add(AuthInterceptor());
  }
}
```

### 2. Replace Mock Data in Home Screen
Edit `lib/screens/home/home_screen.dart`:
```dart
// Replace this:
await Future.delayed(const Duration(seconds: 1));
setState(() {
  _overview = TodayOverview.mock();
});

// With this:
final apiService = ApiService();
final data = await apiService.getTodayOverview();
setState(() {
  _overview = data;
});
```

### 3. Add Authentication
Edit `lib/screens/auth/login_screen.dart`:
```dart
Future<void> _handleLogin() async {
  // Replace mock login with:
  try {
    final response = await apiService.login(
      _phoneController.text,
      _passwordController.text,
    );
    
    // Save tokens
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('access_token', response.accessToken);
      prefs.setString('refresh_token', response.refreshToken);
    });
    
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  } catch (e) {
    // Handle error
  }
}
```

## 📁 Project Structure Quick Reference

```
lib/
├── config/           # App configuration
│   ├── app_theme.dart       # Colors, fonts, themes
│   └── constants.dart       # Routes, keys, messages
├── models/           # Data models (DTOs)
├── screens/          # UI screens
│   ├── auth/        # Login, registration, OTP
│   ├── home/        # Dashboard
│   ├── meal/        # Meal management
│   ├── payment/     # Payment screens
│   ├── purchase/    # Purchase screens
│   └── profile/     # Settings & profile
├── widgets/          # Reusable components
├── utils/            # Helpers & validators
└── main.dart         # App entry point
```

## 🐛 Troubleshooting

### Issue: "Target URI doesn't exist" errors
```bash
# Solution 1: Clean and rebuild
flutter clean
flutter pub get

# Solution 2: Restart IDE
# Close and reopen VS Code/Android Studio

# Solution 3: Clear Dart analysis cache
rm -rf .dart_tool/
flutter pub get
```

### Issue: Build fails
```bash
# Check Flutter doctor
flutter doctor -v

# Update Flutter
flutter upgrade

# Check dependencies
flutter pub outdated
flutter pub upgrade
```

### Issue: App crashes on startup
```bash
# Check logs
flutter run --verbose

# Clear app data (Android)
adb shell pm clear com.example.trying_flutter
```

## 📦 Building for Production

### Android APK
```bash
# Build release APK
flutter build apk --release

# Build split APKs (smaller size)
flutter build apk --split-per-abi

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS (requires Mac)
```bash
flutter build ios --release

# Open in Xcode for signing
open ios/Runner.xcworkspace
```

## 🎯 Next Development Steps

1. **Implement API Integration**
   - Create API service class
   - Replace all mock data
   - Add error handling
   - Implement token refresh

2. **Add State Management**
   - Set up Provider
   - Create providers for auth, meals, payments
   - Implement global state

3. **Complete Missing Screens**
   - Purchase entry form
   - Member meal list
   - Payment history
   - Monthly overview

4. **Add Local Storage**
   - Cache user data
   - Store token securely
   - Implement offline mode

5. **Testing**
   - Write unit tests
   - Add widget tests
   - Integration testing

6. **Polish**
   - Add animations
   - Improve UX
   - Optimize performance
   - Add analytics

## 📚 Useful Commands

```bash
# Hot reload (in running app)
r

# Hot restart
R

# Format code
flutter format lib/

# Analyze code
flutter analyze

# Run tests
flutter test

# Generate icons
flutter pub run flutter_launcher_icons:main

# Update dependencies
flutter pub upgrade

# Check outdated packages
flutter pub outdated
```

## 💡 Tips

1. **Use Hot Reload**: Press `r` in terminal while app is running to see changes instantly
2. **Debug Mode**: Use Flutter DevTools for debugging (run `flutter pub global activate devtools`)
3. **Print Debugging**: Use `debugPrint()` instead of `print()` for better logging
4. **Widget Inspector**: Enable in VS Code or Android Studio to inspect widget tree
5. **Performance**: Use `const` constructors wherever possible for better performance

## 🆘 Getting Help

- Flutter Docs: https://docs.flutter.dev
- DartPad (online editor): https://dartpad.dev
- Stack Overflow: Tag `flutter`
- Flutter Discord: https://discord.gg/flutter

## ✅ Pre-Launch Checklist

- [ ] All screens tested on different devices
- [ ] API integration complete
- [ ] Error handling implemented
- [ ] Loading states everywhere
- [ ] Form validation working
- [ ] Authentication flow secure
- [ ] App icons and splash screen set
- [ ] App name and package name updated
- [ ] Permissions configured (Android & iOS)
- [ ] Release build tested
- [ ] Privacy policy added
- [ ] Terms & conditions added

---

**Ready to code! Happy development! 🎉**
