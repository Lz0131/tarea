import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Restablecer contraseña por correo
  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Procesandon tu petición', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Validacion del Form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Enviar correo electrónico para restablecer la contraseña
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      /// Quitar Loader
      TFullScreenLoader.stopLoading();

      /// Mostrar pantalla de éxito
      TLoaders.successSnackBar(
          title: 'Correo enviado',
          message: 'Email Link Sent to Reset your Password.'.tr);

      /// Redireccionar
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, a ocurrido un error', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Procesandon tu petición', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Enviar correo electrónico para restablecer la contraseña
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Quitar Loader
      TFullScreenLoader.stopLoading();

      /// Mostrar pantalla de éxito
      TLoaders.successSnackBar(
          title: 'Correo enviado',
          message: 'Email Link Sent to Reset your Password.'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, a ocurrido un error', message: e.toString());
    }
  }
}
