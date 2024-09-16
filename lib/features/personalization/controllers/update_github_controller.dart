import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas/data/repositories/user/user_repository.dart';
import 'package:tareas/features/personalization/controllers/user_controller.dart';
import 'package:tareas/features/personalization/screens/profile/profile.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateGitHubController extends GetxController {
  static UpdateGitHubController get instance => Get.find();

  final githubT = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateGitHubFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    githubT.text = userController.user.value.github;
  }

  Future<void> updateGitHub() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Estamos cargando tu información...', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Validacion del formulario
      if (!updateGitHubFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Actualizar el nombre y apellido del usuario en Firebase Firestore
      Map<String, dynamic> github = {'GitHub': githubT.text.trim()};
      await userRepository.updateSingleField(github);

      userController.user.value.github = githubT.text.trim();

      /// Mensaje de exito
      TLoaders.successSnackBar(
          title: 'Hecho', message: 'Actualizamos tu información');

      /// Regresar al Screen anterior
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }

  Future<void> ir() async {
    /// Revisando conectividad
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    /// Validacion del formulario
    if (!updateGitHubFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    final url = githubT.text.trim();

    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }
}
