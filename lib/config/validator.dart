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
    // Check for minimum password length
    if (value.length < 6) {
      return 'The password must be at least 6 characters';
    }
    return null; // Return null if validation passes
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
