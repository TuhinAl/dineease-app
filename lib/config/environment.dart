class Environment {
  static const bool production = false;
  static const String profile = 'local';

  // API Base URLs
  static const String memberAuthService = 'http://localhost:9000';
  static const String notificationsWebsocket =
      'http://localhost:9000/dine-ease/api/v1';

  // Context Paths
  static const String contextPath = '$memberAuthService/dine-ease/api/v1';
}

class ApiEndpoints {
  // Auth Endpoints
  static const String memberLogin =
      '${Environment.contextPath}/member/secure/login';
  static const String memberDineAssociate =
      '${Environment.contextPath}/dine/member-associate';
  static const String memberRegister =
      '${Environment.contextPath}/member/secure/register';
  static const String phoneVerification =
      '${Environment.contextPath}/member/secure/phone-verify';
  static const String otpVerification =
      '${Environment.contextPath}/member/secure/otp-verify';
  static const String forgotPassword =
      '${Environment.contextPath}/member/secure/forgot-password';
  static const String resetPassword =
      '${Environment.contextPath}/member/secure/reset-password';

  // Other Endpoints
  static const String currentMonthOverview =
      '${Environment.contextPath}/current-month-overview';
}
