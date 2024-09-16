import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/data/repositories/user/user_repository.dart';
import 'package:tareas/features/authentication/models/user_model.dart';
import 'package:tareas/features/authentication/screens/signup/verify_email.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPoliy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  void signup() async {
    try {
      /// Cargando Inicio
      TFullScreenLoader.openLoadingDialog(
          'Estamos procesando tu información ...', TImages.docerAnimation);

      /// Verificar la conectividad a Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      /// validación del formulario
      if (!signupFormKey.currentState!.validate()) return;

      /// verificación de política de privacidad
      if (!privacyPoliy.value) {
        TLoaders.warningSnackBar(
            title: 'Acepta las politicas de Seguridad',
            message:
                'Para crear una cuenta, debe leer y aceptar la Política de privacidad y los Términos de uso.');
      }

      /// registrar usuario en Firebase Authentication y guardar datos de usuario en Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      /// Guarde los datos del usuario autenticado en Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        github: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      /// Mostrar mensaje de éxitoe
      TLoaders.successSnackBar(
          title: 'Felicidades',
          message:
              '¡Tu cuenta ha sido creada! Verifica tu correo para poder continuar.');
      TFullScreenLoader.stopLoading();
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      /// Ver errores generales
      TLoaders.errorSnackBar(
          title: 'Oh No! A ocurrido un error', message: e.toString());
    } finally {
      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Ir a verificacion de correo
    }
  }
}
