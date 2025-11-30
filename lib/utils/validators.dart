class Validators {
  // Phone Number: 11 digits
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 11) {
      return 'Please enter a valid 11-digit phone number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  // Password: Min 8 characters
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Confirm Password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Email: Valid email format (optional)
  static String? validateEmail(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'Email is required' : null;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Full Name
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 3) {
      return 'Full name must be at least 3 characters';
    }
    return null;
  }

  // Meal Count: 0-9
  static String? validateMealCount(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional
    }
    final count = int.tryParse(value);
    if (count == null || count < 0 || count > 9) {
      return 'Value must be between 0 and 9';
    }
    return null;
  }

  // Amount: Positive number
  static String? validateAmount(String? value, {bool required = true}) {
    if (value == null || value.isEmpty) {
      return required ? 'Amount is required' : null;
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  // Item Name
  static String? validateItemName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Item name is required';
    }
    return null;
  }

  // Quantity
  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Please enter a valid quantity';
    }
    return null;
  }

  // OTP: 6 digits
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'Please enter a valid 6-digit OTP';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP must contain only digits';
    }
    return null;
  }
}
