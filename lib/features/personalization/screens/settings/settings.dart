import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tareas/common/widgets/appbar/appbar.dart';
import 'package:tareas/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:tareas/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:tareas/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:tareas/common/widgets/texts/section_heading.dart';
import 'package:tareas/data/repositories/authentication/authentication_repository.dart';
import 'package:tareas/features/personalization/screens/address/address.dart';
import 'package:tareas/features/personalization/screens/profile/profile.dart';
import 'package:tareas/utils/constants/colors.dart';
import 'package:tareas/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --------- Encebezado ---------

            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// ------------ AppBar ------------
                  TAppBar(
                    title: Text('Cuenta',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white)),
                  ),

                  /// ------------ Perfil del usuario ------------
                  TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// --------- Body ---------
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// --------- Configuracion de la cuenta ---------
                  TSectionHeading(
                      title: 'Ajustes de la Cuenta', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'Dirección',
                    subTitle: 'Recibe los paquetes en tu direccion',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'Mi Carrito',
                    subTitle: 'Agrega, elimina productos y continua para pagar',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Mis pedidos',
                    subTitle: 'Revisa el estatus de tus compras',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Metodo de pago',
                    subTitle: 'Registra un metodo de pago',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'Mis Cupones',
                    subTitle: 'Lista de cupones activos',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notificaciones',
                    subTitle:
                        'Establecer cualquier tipo de mensaje de notificación',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Ajustes de Privacidad',
                    subTitle:
                        'Administrar el uso de datos y las cuentas conectadas',
                    onTap: () {},
                  ),

                  /// ------ Ajustes de la Aplicacion
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                      title: 'Ajustes de la App', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Cargar Datos',
                    subTitle: 'Carga tu información de Firebase',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Localización',
                    subTitle: 'Recomendaciones basadas en la localización',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Modo Seguro',
                    subTitle:
                        'El resultado de la búsqueda es seguro para todas las edades',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Calidad de imagen HD',
                    subTitle:
                        'Establecer calidad de visualización de las imagenesz',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// ----- Boton para cerrar sesion
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Cerrar sesión')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
