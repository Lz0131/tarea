/// Custom exception class to handle various format-related errors.
class TFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const TFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
            'El formato de la dirección de correo electrónico es inválido. Por favor, introduce un correo electrónico válido.');
      case 'invalid-phone-number-format':
        return const TFormatException(
            'El formato del número de teléfono proporcionado es inválido. Por favor, introduce un número válido.');
      case 'invalid-date-format':
        return const TFormatException(
            'El formato de fecha es inválido. Por favor, introduce una fecha válida.');
      case 'invalid-url-format':
        return const TFormatException(
            'El formato de URL es inválido. Por favor, introduce una URL válida.');
      case 'invalid-credit-card-format':
        return const TFormatException(
            'El formato de la tarjeta de crédito es inválido. Por favor, introduce un número de tarjeta de crédito válido.');
      case 'invalid-numeric-format':
        return const TFormatException(
            'El formato de entrada debe ser numérico.');
      // Agrega más casos según sea necesario...
      default:
        return const TFormatException();
    }
  }
}
