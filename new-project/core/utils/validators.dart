class Validators {
  // ========== Basic Validators ==========

  /// Validates if a field is required (not null or empty)
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }
    return null;
  }

  /// Validates if a field is not null or empty, returns bool
  static bool isRequired(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  // ========== Email Validators ==========

  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validates email format with custom error message
  static String? validateEmailWithMessage(
    String? value, {
    String? errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return errorMessage ?? 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return errorMessage ?? 'Please enter a valid email';
    }

    return null;
  }

  /// Checks if email format is valid, returns bool
  static bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  // ========== Password Validators ==========

  /// Basic password validation (minimum 8 characters)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  /// Strong password validation with multiple criteria
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validates password confirmation
  static String? validatePasswordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Custom password validation with configurable requirements
  static String? validateCustomPassword(
    String? value, {
    int minLength = 8,
    int maxLength = 50,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Password must be less than $maxLength characters';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireNumbers && !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (requireSpecialChars &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // ========== Phone Number Validators ==========

  /// Basic phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Egyptian phone number validation
  static String? validateEgyptianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces and special characters
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Egyptian phone patterns
    final egyptianPhoneRegex = RegExp(r'^(\+20|0020|20|0)?(1[0125]|15)\d{8}$');

    if (!egyptianPhoneRegex.hasMatch(cleanedValue)) {
      return 'Please enter a valid Egyptian phone number';
    }

    return null;
  }

  /// Saudi phone number validation
  static String? validateSaudiPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final saudiPhoneRegex = RegExp(r'^(\+966|0096?6?|966|0)?5[0-9]{8}$');

    if (!saudiPhoneRegex.hasMatch(cleanedValue)) {
      return 'Please enter a valid Saudi phone number';
    }

    return null;
  }

  // ========== Name Validators ==========

  /// Validates full name (first and last name)
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Check if name contains at least first and last name
    final nameParts = value.trim().split(' ');
    if (nameParts.length < 2) {
      return 'Please enter your full name (first and last name)';
    }

    // Check if name contains only letters and spaces
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters';
    }

    return null;
  }

  /// Validates first name
  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }

    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }

    if (value.trim().length > 25) {
      return 'First name must be less than 25 characters';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF]+$');
    if (!nameRegex.hasMatch(value.trim())) {
      return 'First name can only contain letters';
    }

    return null;
  }

  /// Validates last name
  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required';
    }

    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }

    if (value.trim().length > 25) {
      return 'Last name must be less than 25 characters';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF]+$');
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Last name can only contain letters';
    }

    return null;
  }

  // ========== Length Validators ==========

  /// Validates minimum length
  static String? validateMinLength(
    String? value,
    int minLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'Field'} must be at least $minLength characters';
    }

    return null;
  }

  /// Validates maximum length
  static String? validateMaxLength(
    String? value,
    int maxLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (value.length > maxLength) {
      return '${fieldName ?? 'Field'} must be less than $maxLength characters';
    }

    return null;
  }

  /// Validates exact length
  static String? validateExactLength(
    String? value,
    int exactLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (value.length != exactLength) {
      return '${fieldName ?? 'Field'} must be exactly $exactLength characters';
    }

    return null;
  }

  /// Validates length range
  static String? validateLengthRange(
    String? value,
    int minLength,
    int maxLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (value.length < minLength || value.length > maxLength) {
      return '${fieldName ?? 'Field'} must be between $minLength and $maxLength characters';
    }

    return null;
  }

  // ========== Number Validators ==========

  /// Validates if string is a number
  static String? validateNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'Field'} must be a valid number';
    }

    return null;
  }

  /// Validates integer
  static String? validateInteger(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'Field'} must be a valid integer';
    }

    return null;
  }

  /// Validates positive number
  static String? validatePositiveNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'Field'} must be a valid number';
    }

    if (number <= 0) {
      return '${fieldName ?? 'Field'} must be a positive number';
    }

    return null;
  }

  /// Validates number range
  static String? validateNumberRange(
    String? value,
    double min,
    double max, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'Field'} must be a valid number';
    }

    if (number < min || number > max) {
      return '${fieldName ?? 'Field'} must be between $min and $max';
    }

    return null;
  }

  // ========== Age Validators ==========

  /// Validates age
  static String? validateAge(
    String? value, {
    int minAge = 13,
    int maxAge = 120,
  }) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid age';
    }

    if (age < minAge) {
      return 'Age must be at least $minAge years';
    }

    if (age > maxAge) {
      return 'Age must be less than $maxAge years';
    }

    return null;
  }

  // ========== Date Validators ==========

  /// Validates date format (YYYY-MM-DD)
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Please enter a valid date (YYYY-MM-DD)';
    }
  }

  /// Validates date of birth
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth is required';
    }

    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();

      if (date.isAfter(now)) {
        return 'Date of birth cannot be in the future';
      }

      final age = now.difference(date).inDays / 365;
      if (age < 13) {
        return 'You must be at least 13 years old';
      }

      if (age > 120) {
        return 'Please enter a valid date of birth';
      }

      return null;
    } catch (e) {
      return 'Please enter a valid date';
    }
  }

  // ========== URL Validators ==========

  /// Validates URL format
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validates website URL
  static String? validateWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid website URL';
    }

    return null;
  }

  // ========== Card Validators ==========

  /// Validates credit card number using Luhn algorithm
  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove spaces and hyphens
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-]'), '');

    if (cleanedValue.length < 13 || cleanedValue.length > 19) {
      return 'Credit card number must be between 13 and 19 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
      return 'Credit card number can only contain digits';
    }

    // Luhn algorithm
    if (!_isValidLuhn(cleanedValue)) {
      return 'Please enter a valid credit card number';
    }

    return null;
  }

  /// Validates CVV
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }

    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
      return 'CVV must be 3 or 4 digits';
    }

    return null;
  }

  /// Validates expiry date (MM/YY)
  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!expiryRegex.hasMatch(value)) {
      return 'Please enter expiry date in MM/YY format';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiryDate = DateTime(year, month);

    if (expiryDate.isBefore(DateTime(now.year, now.month))) {
      return 'Card has expired';
    }

    return null;
  }

  // ========== Address Validators ==========

  /// Validates address
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }

    if (value.trim().length < 5) {
      return 'Address must be at least 5 characters';
    }

    if (value.trim().length > 200) {
      return 'Address must be less than 200 characters';
    }

    return null;
  }

  /// Validates postal code
  static String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postal code is required';
    }

    // Generic postal code validation (adjust based on country)
    if (!RegExp(r'^[A-Za-z0-9\s\-]{3,10}$').hasMatch(value)) {
      return 'Please enter a valid postal code';
    }

    return null;
  }

  // ========== National ID Validators ==========

  /// Validates Egyptian National ID
  static String? validateEgyptianNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }

    if (value.length != 14) {
      return 'National ID must be 14 digits';
    }

    if (!RegExp(r'^[0-9]{14}$').hasMatch(value)) {
      return 'National ID can only contain digits';
    }

    // Basic validation for Egyptian National ID format
    final century = int.parse(value.substring(0, 1));
    if (century < 2 || century > 3) {
      return 'Invalid National ID format';
    }

    return null;
  }

  /// Validates Saudi National ID
  static String? validateSaudiNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }

    if (value.length != 10) {
      return 'National ID must be 10 digits';
    }

    if (!RegExp(r'^[12][0-9]{9}$').hasMatch(value)) {
      return 'Invalid National ID format';
    }

    return null;
  }

  // ========== Username Validators ==========

  /// Validates username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    if (value.startsWith('_') || value.endsWith('_')) {
      return 'Username cannot start or end with underscore';
    }

    return null;
  }

  // ========== Custom Validators ==========

  /// Validates against custom regex pattern
  static String? validatePattern(
    String? value,
    String pattern,
    String errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }

  /// Validates using custom function
  static String? validateCustom(
    String? value,
    bool Function(String?) validator,
    String errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    if (!validator(value)) {
      return errorMessage;
    }

    return null;
  }

  // ========== Helper Methods ==========

  /// Luhn algorithm for credit card validation
  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Combines multiple validators
  static String? Function(String?) combineValidators(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  /// Validates only if field is not empty (optional field validation)
  static String? Function(String?) optionalValidator(
    String? Function(String?) validator,
  ) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // Skip validation for empty optional fields
      }
      return validator(value);
    };
  }
}
