import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tareas/common/widgets/appbar/appbar.dart';
import 'package:tareas/common/widgets/images/t_circular_image.dart';
import 'package:tareas/common/widgets/texts/section_heading.dart';
import 'package:tareas/features/personalization/controllers/user_controller.dart';
import 'package:tareas/features/personalization/screens/profile/widgets/change_github.dart';
import 'package:tareas/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:tareas/features/personalization/screens/profile/widgets/change_phone.dart';
import 'package:tareas/features/personalization/screens/profile/widgets/change_username.dart';
import 'package:tareas/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:tareas/utils/constants/image_strings.dart';
import 'package:tareas/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      /// ----- AppBar
      appBar: const TAppBar(showBackArrow: true, title: Text('Perfil')),

      /// ---------- Body -------------
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// ---------- Foto de Perfil ------------
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;

                      return controller.imageUploading.value
                          ? TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty)
                          : TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Cambiar foto de perfil')),
                  ],
                ),
              ),

              /// ----------- Detalles -----------
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Informacion del usuario
              const TSectionHeading(
                  title: 'Información del Perfil', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(
                () => TProfileMenu(
                    onPresed: () => Get.to(() => const ChangeName()),
                    title: 'Nombre',
                    value: controller.user.value.fullName),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () => Get.to(() => const ChangeUsername()),
                    title: 'Username',
                    value: controller.user.value.username),
              ),

              /// Heading Informacion personal
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(
                  title: 'Información del Personal', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(
                () => TProfileMenu(
                  onPresed: () {
                    Clipboard.setData(
                        ClipboardData(text: controller.user.value.id));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Texto copiado en portapapeles.')));
                  },
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                ),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () {},
                    title: 'Correo',
                    value: controller.user.value.email),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () => Get.to(() => const ChangeGitHub()),
                    title: 'GitHub',
                    value: controller.user.value.github),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () => Get.to(() => const ChangePhone()),
                    title: 'Telefono',
                    value: controller.user.value.phoneNumber),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () {},
                    title: 'Genero',
                    value: controller.user.value.gender!),
              ),
              Obx(
                () => TProfileMenu(
                    onPresed: () {},
                    title: 'F. Nacimiento',
                    value: controller.user.value.birthdate!),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Cerrar cuenta',
                      style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
