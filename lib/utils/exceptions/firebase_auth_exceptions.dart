/// Custom exception class to handle various Firebase authentication-related errors.
class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'La dirección de correo electrónico ya está registrada. Por favor, usa un correo diferente.';
      case 'invalid-email':
        return 'La dirección de correo electrónico proporcionada es inválida. Por favor, introduce un correo válido.';
      case 'weak-password':
        return 'La contraseña es demasiado débil. Por favor, elige una contraseña más fuerte.';
      case 'user-disabled':
        return 'Esta cuenta de usuario ha sido deshabilitada. Por favor, contacta con el soporte para obtener ayuda.';
      case 'user-not-found':
        return 'Detalles de inicio de sesión inválidos. Usuario no encontrado.';
      case 'wrong-password':
        return 'Contraseña incorrecta. Por favor, verifica tu contraseña e inténtalo de nuevo.';
      case 'invalid-verification-code':
        return 'Código de verificación inválido. Por favor, introduce un código válido.';
      case 'invalid-verification-id':
        return 'ID de verificación inválido. Por favor, solicita un nuevo código de verificación.';
      case 'quota-exceeded':
        return 'Cuota excedida. Por favor, inténtalo de nuevo más tarde.';
      case 'email-already-exists':
        return 'La dirección de correo electrónico ya existe. Por favor, usa un correo diferente.';
      case 'provider-already-linked':
        return 'La cuenta ya está vinculada con otro proveedor.';
      case 'requires-recent-login':
        return 'Esta operación es sensible y requiere autenticación reciente. Por favor, inicia sesión de nuevo.';
      case 'credential-already-in-use':
        return 'Esta credencial ya está asociada con otra cuenta de usuario.';
      case 'user-mismatch':
        return 'Las credenciales proporcionadas no corresponden al usuario que ha iniciado sesión anteriormente.';
      case 'account-exists-with-different-credential':
        return 'Ya existe una cuenta con el mismo correo electrónico pero diferentes credenciales de inicio de sesión.';
      case 'operation-not-allowed':
        return 'Esta operación no está permitida. Contacta con el soporte para obtener ayuda.';
      case 'expired-action-code':
        return 'El código de acción ha expirado. Por favor, solicita un nuevo código de acción.';
      case 'invalid-action-code':
        return 'El código de acción es inválido. Por favor, verifica el código e inténtalo de nuevo.';
      case 'missing-action-code':
        return 'Falta el código de acción. Por favor, proporciona un código de acción válido.';
      case 'user-token-expired':
        return 'El token del usuario ha expirado y se requiere autenticación. Por favor, inicia sesión de nuevo.';
      case 'user-not-found':
        return 'No se encontró ningún usuario para el correo electrónico o UID proporcionado.';
      case 'invalid-credential':
        return 'La credencial proporcionada está mal formada o ha expirado.';
      case 'wrong-password':
        return 'La contraseña es inválida. Por favor, verifica tu contraseña e inténtalo de nuevo.';
      case 'user-token-revoked':
        return 'El token del usuario ha sido revocado. Por favor, inicia sesión de nuevo.';
      case 'invalid-message-payload':
        return 'La carga útil del mensaje de verificación de correo electrónico es inválida.';
      case 'invalid-sender':
        return 'El remitente del correo electrónico es inválido. Por favor, verifica el correo del remitente.';
      case 'invalid-recipient-email':
        return 'La dirección de correo electrónico del destinatario es inválida. Por favor, proporciona un correo válido.';
      case 'missing-iframe-start':
        return 'La plantilla de correo electrónico no tiene la etiqueta de inicio de iframe.';
      case 'missing-iframe-end':
        return 'La plantilla de correo electrónico no tiene la etiqueta de cierre de iframe.';
      case 'missing-iframe-src':
        return 'La plantilla de correo electrónico no tiene el atributo src del iframe.';
      case 'auth-domain-config-required':
        return 'La configuración de authDomain es necesaria para el enlace de verificación del código de acción.';
      case 'missing-app-credential':
        return 'Falta la credencial de la aplicación. Por favor, proporciona credenciales de aplicación válidas.';
      case 'invalid-app-credential':
        return 'La credencial de la aplicación es inválida. Por favor, proporciona una credencial válida.';
      case 'session-cookie-expired':
        return 'La cookie de sesión de Firebase ha expirado. Por favor, inicia sesión de nuevo.';
      case 'uid-already-exists':
        return 'El ID de usuario proporcionado ya está en uso por otro usuario.';
      case 'invalid-cordova-configuration':
        return 'La configuración de Cordova proporcionada es inválida.';
      case 'app-deleted':
        return 'Esta instancia de FirebaseApp ha sido eliminada.';
      case 'user-disabled':
        return 'La cuenta de usuario ha sido deshabilitada.';
      case 'user-token-mismatch':
        return 'El token proporcionado del usuario no coincide con el ID de usuario autenticado.';
      case 'web-storage-unsupported':
        return 'El almacenamiento web no es compatible o está deshabilitado.';
      case 'invalid-credential':
        return 'La credencial proporcionada es inválida. Por favor, verifica la credencial e inténtalo de nuevo.';
      case 'app-not-authorized':
        return 'La aplicación no está autorizada para usar Firebase Authentication con la clave API proporcionada.';
      case 'keychain-error':
        return 'Ocurrió un error en el llavero. Por favor, verifica el llavero e inténtalo de nuevo.';
      case 'internal-error':
        return 'Ocurrió un error interno de autenticación. Por favor, inténtalo de nuevo más tarde.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Credenciales de inicio de sesión inválidas.';
      default:
        return 'Ocurrió un error de autenticación inesperado. Por favor, inténtalo de nuevo.';
    }
  }
}
