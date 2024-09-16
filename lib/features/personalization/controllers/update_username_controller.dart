import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas/data/repositories/user/user_repository.dart';
import 'package:tareas/features/personalization/controllers/user_controller.dart';
import 'package:tareas/features/personalization/screens/profile/profile.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';

class UpdateUserNameController extends GetxController {
  static UpdateUserNameController get instance => Get.find();

  final userName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    userName.text = userController.user.value.username;
  }

  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Actualizar el nombre y apellido del usuario en Firebase Firestore
      Map<String, dynamic> username = {'Username': userName.text.trim()};
      await userRepository.updateSingleField(username);

      userController.user.value.username = userName.text.trim();

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
}
