# DineEase Flutter Mobile App

A comprehensive mess/dining management system designed to help users manage their daily meals, track expenses, handle payments, and collaborate with mess members.

## 📱 Features

### Authentication
- **Splash Screen** - Beautiful animated splash screen with app logo
- **Login** - Phone number and password authentication
- **Phone Registration** - OTP-based phone verification
- **OTP Verification** - 6-digit OTP with countdown timer
- **Member Registration** - Complete profile setup

### Main Features
- **Home Dashboard** - Today's meal overview with personal and mess totals
- **Meal Entry** - Record daily meal consumption (Breakfast, Lunch, Dinner)
- **Purchase Management** - Track mess purchases and expenses
- **Payment Entry** - Record and manage payments
- **Profile Settings** - Update profile and change password

## 🎨 Design System

### Color Palette
- **Primary Color**: #2196F3 (Blue)
- **App Bar Color**: #0a3e03 (Dark Green)
- **Accent Color**: #FF7F0E (Orange)
- **Meal Colors**:
  - Breakfast: #FFA726 (Orange)
  - Lunch: #66BB6A (Green)
  - Dinner: #42A5F5 (Blue)

### Theme Support
- ✅ Light Theme
- ✅ Dark Theme
- Material Design 3

## 📁 Project Structure

```
lib/
├── config/
│   ├── app_theme.dart          # Theme configuration and colors
│   └── constants.dart          # App constants and routes
├── models/
│   ├── member_info_dto.dart    # Member information model
│   ├── meal_history_dto.dart   # Meal history model
│   ├── purchase_history_dto.dart # Purchase model
│   ├── payment_history_dto.dart  # Payment model
│   └── overview_dto.dart       # Overview data models
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── phone_registration_screen.dart
│   │   ├── otp_verification_screen.dart
│   │   └── member_registration_screen.dart
│   ├── home/
│   │   └── home_screen.dart    # Dashboard with meal overview
│   ├── meal/
│   │   └── meal_entry_screen.dart
│   ├── purchase/
│   │   └── purchase_list_screen.dart
│   ├── payment/
│   │   └── payment_entry_screen.dart
│   ├── profile/
│   │   └── profile_settings_screen.dart
│   └── main_screen.dart        # Bottom navigation container
├── utils/
│   ├── validators.dart         # Form validation functions
│   └── helpers.dart            # Date/currency helpers
├── widgets/
│   ├── page_header.dart        # Reusable page header
│   ├── custom_card.dart        # Custom card widget
│   ├── loading_indicator.dart  # Loading states
│   ├── empty_state.dart        # Empty state widget
│   └── error_state.dart        # Error state widget
└── main.dart                   # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd trying_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.0.0              # State management
  dio: ^5.0.0                   # HTTP client
  shared_preferences: ^2.0.0    # Local storage
  intl: ^0.18.0                 # Date formatting
  pin_code_fields: ^8.0.0       # OTP input
  flutter_form_builder: ^9.0.0  # Form validation
  fluttertoast: ^8.0.0          # Toast messages
  flutter_spinkit: ^5.0.0       # Loading indicators
  font_awesome_flutter: ^10.0.0 # Icons
  fl_chart: ^0.60.0             # Charts (optional)
```

## 🎯 Navigation Flow

### Authentication Flow
```
Splash Screen → Login Screen
                    ↓
           Phone Registration
                    ↓
          OTP Verification
                    ↓
         Member Registration
                    ↓
              Home Screen
```

### Main App Flow (Bottom Navigation)
```
Home → Meal Entry → Purchase → Payment → Profile
```

## 🔐 Mock Data

Currently, the app uses mock data for demonstration purposes. All API calls are simulated with delays.

### Mock User
- Name: John Doe
- Phone: 01712345678
- Email: john@example.com

### Mock Today's Overview
- Your Meals: Breakfast (2), Lunch (1), Dinner (2)
- Mess Total: Breakfast (8), Lunch (7), Dinner (9)

## 📱 Screenshots

The app includes the following screens:
1. **Splash Screen** - Animated logo and branding
2. **Login** - Phone & password authentication
3. **Home Dashboard** - Meal overview cards
4. **Meal Entry** - Beautiful meal input interface
5. **Payment Entry** - Simple payment form
6. **Profile** - Tabbed profile & password management

## 🎨 UI Components

### Common Components
- **PageHeader** - Consistent header across screens
- **CustomCard** - Elevated cards with shadows
- **LoadingIndicator** - Spinners for async operations
- **EmptyState** - Friendly empty state messages
- **ErrorState** - Error handling UI

### Form Validation
- Phone: 11 digits required
- Password: Minimum 8 characters
- Email: Valid format (optional)
- OTP: 6 digits
- Meal Count: 0-9 range

## 🌐 API Integration (Future)

The app is structured to easily integrate with backend APIs. Replace mock data in screens with actual API calls using Dio.

### Endpoints (Planned)
- POST `/auth/login`
- POST `/auth/register`
- GET `/meals/today`
- POST `/meals`
- POST `/payments`
- GET `/purchases`

## 🔧 Configuration

### Theme Mode
Edit `main.dart` to change theme mode:
```dart
themeMode: ThemeMode.light,  // or ThemeMode.dark or ThemeMode.system
```

### Colors
Edit `lib/config/app_theme.dart` to customize colors

## 📝 TODO / Future Enhancements

- [ ] Connect to backend API
- [ ] Implement state management (Provider/Riverpod)
- [ ] Add member meal history screen
- [ ] Create purchase entry form
- [ ] Add payment history list
- [ ] Implement current month overview
- [ ] Add charts and analytics
- [ ] Push notifications
- [ ] Offline support
- [ ] Dark mode toggle
- [ ] Multi-language support
- [ ] Export to PDF/Excel

## 🤝 Contributing

This is a demo project based on design guidelines. Feel free to fork and customize for your needs.

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Developer

Built with ❤️ using Flutter

---

**Note**: This is a UI-only implementation with mock data. API integration and full functionality need to be implemented based on your backend requirements.
