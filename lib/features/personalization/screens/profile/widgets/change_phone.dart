import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tareas/common/widgets/appbar/appbar.dart';
import 'package:tareas/features/personalization/controllers/update_phone_controller.dart';
import 'package:tareas/utils/constants/sizes.dart';
import 'package:tareas/utils/constants/text_strings.dart';
import 'package:tareas/utils/validators/validation.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Modificar el Telefono'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Headings
            Text(
              'Escribe tu numero de telefono para actualizar',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// text field y button
            Form(
              key: controller.updatePhoneFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phoneT,
                    validator: (value) =>
                        TValidator.validateEmptyText('Telefono', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.phone,
                        prefixIcon: Icon(Iconsax.link)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updatePhone(),
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
