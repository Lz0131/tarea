/// Exception class for handling various errors.
class TExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const TExceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);

  /// Create an authentication exception from a Firebase authentication exception code.
  factory TExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TExceptions(
            'La dirección de correo electrónico ya está registrada. Por favor, usa un correo diferente.');
      case 'invalid-email':
        return const TExceptions(
            'La dirección de correo electrónico proporcionada es inválida. Por favor, introduce un correo válido.');
      case 'weak-password':
        return const TExceptions(
            'La contraseña es demasiado débil. Por favor, elige una contraseña más fuerte.');
      case 'user-disabled':
        return const TExceptions(
            'Esta cuenta de usuario ha sido deshabilitada. Por favor, contacta con el soporte para obtener ayuda.');
      case 'user-not-found':
        return const TExceptions(
            'Detalles de inicio de sesión inválidos. Usuario no encontrado.');
      case 'wrong-password':
        return const TExceptions(
            'Contraseña incorrecta. Por favor, verifica tu contraseña e inténtalo de nuevo.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const TExceptions(
            'Credenciales de inicio de sesión inválidas. Por favor, verifica tu información.');
      case 'too-many-requests':
        return const TExceptions(
            'Demasiadas solicitudes. Por favor, inténtalo de nuevo más tarde.');
      case 'invalid-argument':
        return const TExceptions(
            'Argumento inválido proporcionado al método de autenticación.');
      case 'invalid-password':
        return const TExceptions(
            'Contraseña incorrecta. Por favor, inténtalo de nuevo.');
      case 'invalid-phone-number':
        return const TExceptions(
            'El número de teléfono proporcionado es inválido.');
      case 'operation-not-allowed':
        return const TExceptions(
            'El proveedor de inicio de sesión está deshabilitado para tu proyecto de Firebase.');
      case 'session-cookie-expired':
        return const TExceptions(
            'La cookie de sesión de Firebase ha expirado. Por favor, inicia sesión de nuevo.');
      case 'uid-already-exists':
        return const TExceptions(
            'El ID de usuario proporcionado ya está en uso por otro usuario.');
      case 'sign_in_failed':
        return const TExceptions(
            'El inicio de sesión falló. Por favor, inténtalo de nuevo.');
      case 'network-request-failed':
        return const TExceptions(
            'La solicitud de red falló. Por favor, verifica tu conexión a internet.');
      case 'internal-error':
        return const TExceptions(
            'Error interno. Por favor, inténtalo de nuevo más tarde.');
      case 'invalid-verification-code':
        return const TExceptions(
            'Código de verificación inválido. Por favor, introduce un código válido.');
      case 'invalid-verification-id':
        return const TExceptions(
            'ID de verificación inválido. Por favor, solicita un nuevo código de verificación.');
      case 'quota-exceeded':
        return const TExceptions(
            'Cuota excedida. Por favor, inténtalo de nuevo más tarde.');
      default:
        return const TExceptions();
    }
  }
}
