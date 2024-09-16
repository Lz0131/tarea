import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/features/personalization/controllers/user_controller.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Correo y contraseña SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      /// Inicio de carga
      TFullScreenLoader.openLoadingDialog(
          'Iniciando sesión en tu cuenta', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Validacion del formulario
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Recordar cuenta
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      /// Login user usando EMail & Contraseña para autentificacion
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// Quitar Loader
      TFullScreenLoader.stopLoading();

      /// Redireccionar
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }

  /// Google Autentificacion
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Iniciando tu sesión ...', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Autentificacion por Google
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      /// Guardar usuario
      await userController.saveUserRecord(userCredentials);

      /// Remover Loader
      TFullScreenLoader.stopLoading();

      /// Redireccionar
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }
}
