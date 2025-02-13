class Validation {
  static String? fieldValidation(String? value, String field) {
    if (value!.isEmpty) {
      return 'Please enter $field';
    }
    return null;
  }

  static String? emailValidation(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? confirmPassword(String? value, String confirm) {
    if (value != confirm) {
      return 'Passwords don\'t match';
    } else if (passwordValidation(value) != null) {
      return passwordValidation(value);
    }
    return null;
  }

  static String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
    RegExp regex = RegExp(r'^\+\d{1,3}\d{10,14}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid phone number format. Please include country code starting with +';
    }
    return null;
  }

  static String? cardNumberValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a card number';
    }
    RegExp regex = RegExp(r'^\d{4}\s\d{4}\s\d{4}\s\d{4}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid card number';
    }
    return null;
  }

  static String? expiryDateValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an expiry date';
    }
    RegExp regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid expiry date in MM/YY format';
    }
    return null;
  }

  static String? cvvValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a CVV number';
    }
    RegExp regex = RegExp(r'^\d{3}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid 3-digit CVV number';
    }
    return null;
  }
}
