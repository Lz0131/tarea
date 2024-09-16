import 'package:get/get.dart';
import 'package:tareas/features/authentication/screens/login/login.dart';
import 'package:tareas/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tareas/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:tareas/features/authentication/screens/signup/signup.dart';
import 'package:tareas/features/authentication/screens/signup/verify_email.dart';
import 'package:tareas/features/personalization/screens/address/address.dart';
import 'package:tareas/features/personalization/screens/profile/profile.dart';
import 'package:tareas/features/personalization/screens/settings/settings.dart';
import 'package:tareas/features/shop/screens/home/home.dart';
import 'package:tareas/features/shop/screens/store/store.dart';
import 'package:tareas/features/shop/screens/wishlist/wishlist.dart';
import 'package:tareas/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),

    // Add more GetPage entries as needed
  ];
}
