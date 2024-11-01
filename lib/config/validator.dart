class Validator {
  // Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Check for valid phone number format (10 to 15 digits)
    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null; // Return null if validation passes
  }

  // Validate password
static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Minimum length check
    if (value.length < 8) {
      return 'The password must be at least \n8 characters';
    }

    // Maximum length check (optional, based on your requirements)
    if (value.length > 100) {
      return 'Password must not exceed 100 characters';
    }

    // Check for uppercase letters
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least \none uppercase letter';
    }

    // Check for lowercase letters
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least \none lowercase letter';
    }

    // Check for numbers
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least \none number';
    }

    // Check for special characters
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least \none special character';
    }

    // Check for common patterns (optional)
    if (RegExp(r'123|abc|password|qwerty', caseSensitive: false).hasMatch(value)) {
      return 'Password contains common patterns \nthat are not allowed like (123,abc,...)';
    }

    // Check for repeating characters (optional)
    if (RegExp(r'(.)\1{2,}').hasMatch(value)) {
      return 'Password should not contain repeating \ncharacters (more than 2 times)';
    }

    // Return null if validation passes
    return null;
  }

  // Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Basic email format validation
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null; // Return null if validation passes
  }

  // Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fill this feild';
    }
    // Check for valid name (can add more checks, like length or character restrictions)
    if (value.length < 2) {
      return 'Name must be \nat least 2 characters';
    }
    return null; // Return null if validation passes
  }
}
