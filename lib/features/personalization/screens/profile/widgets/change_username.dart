import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tareas/common/widgets/appbar/appbar.dart';
import 'package:tareas/features/personalization/controllers/update_username_controller.dart';
import 'package:tareas/utils/constants/sizes.dart';
import 'package:tareas/utils/constants/text_strings.dart';
import 'package:tareas/utils/validators/validation.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserNameController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Modificar UserName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Headings
            Text(
              'Puede usar el nombre u apodo con el que sienta más comodo.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// text field y button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.userName,
                    validator: (value) =>
                        TValidator.validateEmptyText('UserName', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Guardar')),
            ),
          ],
        ),
      ),
    );
  }
}
