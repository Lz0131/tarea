import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/data/repositories/user/user_repository.dart';
import 'package:tareas/features/authentication/models/user_model.dart';
import 'package:tareas/features/authentication/screens/login/login.dart';
import 'package:tareas/features/personalization/controllers/re_authenticate_user_login_form.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/constants/sizes.dart';
import 'package:tareas/utils/helpers/network_manager.dart';
import 'package:tareas/utils/popups/full_screen_loader.dart';
import 'package:tareas/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Obtener registro de usuario
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refrescar User Record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convierte Nombre y Apellido
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            github: '',
            gender: '',
            birthdate: '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Informacion no guardada',
          message:
              'Algo salió mal al guardar tu información. Puedes volver a guardar tus datos en tu perfil.');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Eliminar Cuenta',
      middleText:
          'Estas seguro que quieres eliminar de forma permanente tu cuenta? Esta acción no es reversible y perderas de forma permanente tus datos.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Eliminar')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancelar'),
      ),
    );
  }

  /// Eliminar usuario
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Procesando', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      print('___________________________________________________________');
      print('Entra');
      print('___________________________________________________________');
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      print('___________________________________________________________');
      print('Pasa');
      print('___________________________________________________________');
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          print('___________________________________________________________');
          print('Es correo');
          print('___________________________________________________________');
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }

  /// Reautentificacion
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Procesando', TImages.docerAnimation);

      /// Revisando conectividad
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }

  /// Actualizar los datos
  Future<void> updateUserDetails() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Actualizando datos...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final updatedUser = await userRepository.fetchUserDetails();
      user(updatedUser);

      TFullScreenLoader.stopLoading();
      // Mostrar mensaje de éxito
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    }
  }

  /// Upload Imagen de perfil
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile', image);
        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(
            title: 'Hecho', message: 'La imagen de perfil a sido actualizada');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh no, algo fallo, intentalo de nuevo',
          message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
