import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/constants.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/phone_registration_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/auth/member_registration_screen.dart';
import 'screens/main_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  runApp(const DineEaseApp());
}

class DineEaseApp extends StatelessWidget {
  const DineEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DineEase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.phoneRegistration:
            return MaterialPageRoute(
              builder: (_) => const PhoneRegistrationScreen(),
            );
          case AppRoutes.otpVerification:
            final phoneNumber = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => OTPVerificationScreen(phoneNumber: phoneNumber),
            );
          case AppRoutes.memberRegistration:
            final phoneNumber = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) =>
                  MemberRegistrationScreen(phoneNumber: phoneNumber),
            );
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const MainScreen());
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
