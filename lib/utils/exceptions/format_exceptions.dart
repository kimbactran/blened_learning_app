class EcoFormatException implements Exception {
  final String message;

  const EcoFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  factory EcoFormatException.fromMessage(String message) {
    return EcoFormatException(message);
  }

  String get formattedMessage => message;

  factory EcoFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const EcoFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const EcoFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const EcoFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const EcoFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const EcoFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numberic-format':
        return const EcoFormatException(
            'The input should be a valid numberic format.');
      default:
        return const EcoFormatException(
            'An unexpected Format error occurred. Please try again.');
    }
  }
}
