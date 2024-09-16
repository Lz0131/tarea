import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tareas/common/widgets/success_screen/success_screen.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/constants/text_strings.dart';
import 'package:tareas/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.

  @override
  void onInit() {
    sendEmailVerification();
    super.onInit();
  }

  /// Enviar enlace de verificación por correo electrónico
  void sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Correo enviado',
          message: 'Porfavor verifica tu correo electronico');
    } catch (e) {
      /// Errores generales
      TLoaders.errorSnackBar(
          title: 'Oh No! A ocurrido un error', message: e.toString());
    }
  }

  /// Temporizador para redirigir automáticamente en la verificación de correo electrónico
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: TImages.successfullyRegisterAnimation,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Comprobar manualmente si el correo electrónico está verificado
  checkEmailVerificationStatus() async {
    FirebaseAuth.instance.currentUser?.reload();
    final currentUser = FirebaseAuth.instance.currentUser;
    print('que esta pasando???');
    print(currentUser);
    if (currentUser != null && currentUser.emailVerified) {
      Get.offAll(
        () => SuccessScreen(
          image: TImages.successfullyRegisterAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
