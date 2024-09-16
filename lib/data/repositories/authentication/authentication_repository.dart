import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tareas/data/repositories/user/user_repository.dart';
import 'package:tareas/features/authentication/screens/login/login.dart';
import 'package:tareas/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tareas/features/authentication/screens/signup/verify_email.dart';
import 'package:tareas/navigation_menu.dart';
import 'package:tareas/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:tareas/utils/exceptions/format_exceptions.dart';
import 'package:tareas/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Llamado desde main.dart al iniciar la aplicación
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Funtion to Show Relevant Screen

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      // Verifica si esta verificado
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);

      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* ---------------------- Email & Password sign-In ---------------------- */

  /// EmailAuthentication - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /// [EmailAuthentication] - Registro
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /// ReAuthenticate - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      /// Crear credencial
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      /// Reautentificacion
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /// EmailVerification - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /// EmailAuthentication - Olvidaste el Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /* ---------------------- Google, Facebook & Github sign-In ---------------------- */

  /// GoogleAuthentication -- GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      /// Activar el flujo de autenticación
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      /// Obtener los detalles de autenticación de la solicitud.
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      /// Crear la nueva credencial
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      /// Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Algo salió mal. Inténtalo de nuevo más tarde.');
      return null;
    }
  }

  /// FacebookAuthentication -- FACEBOOK

  /// GithubAuthentication -- GITHUB

  /* ---------------------- Cerrar sesion y Eliminar Cuenta ---------------------- */

  /// LogoutUser / Cerrar Sesion- Valido para cualquier usuario
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }

  /// DELETE USER - Eliminar la Autentificacion del usuario y la cuenta de Firestore
  Future<void> deleteAccount() async {
    try {
      await UserRepository.inistance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Algo salió mal. Inténtalo de nuevo más tarde.';
    }
  }
}
