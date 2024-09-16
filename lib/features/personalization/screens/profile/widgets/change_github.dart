import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tareas/common/widgets/appbar/appbar.dart';
import 'package:tareas/features/personalization/controllers/update_github_controller.dart';
import 'package:tareas/utils/constants/sizes.dart';
import 'package:tareas/utils/constants/text_strings.dart';
import 'package:tareas/utils/validators/validation.dart';

class ChangeGitHub extends StatelessWidget {
  const ChangeGitHub({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGitHubController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Modificar GitHub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Headings
            Text(
              'Escribe la liga a tu perfil de GitHub',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// text field y button
            Form(
              key: controller.updateGitHubFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.githubT,
                    validator: (value) =>
                        TValidator.validateEmptyText('GitHub', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.github,
                        prefixIcon: Icon(Iconsax.link)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateGitHub(),
                  child: const Text('Guardar')),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.ir(), child: const Text('Ir')),
            ),
          ],
        ),
      ),
    );
  }
}
