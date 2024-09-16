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

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phoneT = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    phoneT.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhone() async {
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
      if (!updatePhoneFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Actualizar el nombre y apellido del usuario en Firebase Firestore
      Map<String, dynamic> phone = {'PhoneNumber': phoneT.text.trim()};
      await userRepository.updateSingleField(phone);

      userController.user.value.phoneNumber = phoneT.text.trim();

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
    if (!updatePhoneFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    final url = 'tel:+52' + phoneT.text.trim();

    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }
}
