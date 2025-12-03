class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String memberData = 'member_data';
  static const String phoneNumber = 'phoneNumber';
  static const String userName = 'name';
  static const String userId = 'id';
  static const String dineId = 'dineId';
  static const String themeMode = 'theme_mode';
  static const String otpExpiryTimestamp = 'otp_expiry_timestamp';
  static const String otpPhoneNumber = 'otp_phone_number';
}

class ErrorMessages {
  static const String networkError =
      'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String validationError =
      'Please check your input and try again.';
  static const String authError = 'Authentication failed. Please login again.';
  static const String notFound = 'Requested data not found.';
  static const String permissionDenied =
      'You do not have permission to perform this action.';
}

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String phoneRegistration = '/phone-registration';
  static const String otpVerification = '/otp-verification';
  static const String memberRegistration = '/member-registration';
  static const String forgotPassword = '/forgot-password';
  static const String passwordReset = '/password-reset';

  // Main App Routes
  static const String home = '/home';
  static const String mealEntry = '/meal-entry';
  static const String purchaseEntry = '/purchase-entry';
  static const String memberMealList = '/member-meal-list';
  static const String paymentEntry = '/payment-entry';
  static const String paymentList = '/payment-list';
  static const String purchaseList = '/purchase-list';
  static const String profileSettings = '/profile-settings';
  static const String accountSettings = '/account-settings';
  static const String addMember = '/add-member';
  static const String subscriptionPlan = '/subscription-plan';
  static const String currentMonthOverview = '/current-month-overview';
}
