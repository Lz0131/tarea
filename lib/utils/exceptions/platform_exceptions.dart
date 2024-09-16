/// Exception class for handling various platform-related errors.
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Credenciales de inicio de sesión inválidas. Por favor, verifica tu información.';
      case 'too-many-requests':
        return 'Demasiadas solicitudes. Por favor, inténtalo de nuevo más tarde.';
      case 'invalid-argument':
        return 'Argumento inválido proporcionado al método de autenticación.';
      case 'invalid-password':
        return 'Contraseña incorrecta. Por favor, inténtalo de nuevo.';
      case 'invalid-phone-number':
        return 'El número de teléfono proporcionado es inválido.';
      case 'operation-not-allowed':
        return 'El proveedor de inicio de sesión está deshabilitado para tu proyecto de Firebase.';
      case 'session-cookie-expired':
        return 'La cookie de sesión de Firebase ha expirado. Por favor, inicia sesión de nuevo.';
      case 'uid-already-exists':
        return 'El ID de usuario proporcionado ya está en uso por otro usuario.';
      case 'sign_in_failed':
        return 'El inicio de sesión falló. Por favor, inténtalo de nuevo.';
      case 'network-request-failed':
        return 'La solicitud de red falló. Por favor, verifica tu conexión a internet.';
      case 'internal-error':
        return 'Error interno. Por favor, inténtalo de nuevo más tarde.';
      case 'invalid-verification-code':
        return 'Código de verificación inválido. Por favor, introduce un código válido.';
      case 'invalid-verification-id':
        return 'ID de verificación inválido. Por favor, solicita un nuevo código de verificación.';
      case 'quota-exceeded':
        return 'Cuota excedida. Por favor, inténtalo de nuevo más tarde.';
      // Agrega más casos según sea necesario...
      default:
        return 'Ocurrió un error de plataforma inesperado. Por favor, inténtalo de nuevo.';
    }
  }
}
