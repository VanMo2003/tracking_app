import 'package:traking_app/views/screens/home/drawer/screens/change_password.dart';
import 'package:traking_app/views/screens/home/drawer/screens/info_user_screen.dart';
import 'package:traking_app/views/screens/home/home_screen.dart';
import 'package:traking_app/views/screens/auth/sign_in_screen.dart';
import 'package:traking_app/views/screens/auth/sign_up_screen.dart';

import '../views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String home = "/home";
  static const String infoUser = "/info_user";
  static const String changePassword = "/change_password";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getHomeRoute() => home;
  static String getInfoUser() => infoUser;
  static String getChangePassword() => changePassword;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: infoUser, page: () => InfoUserScreen()),
    GetPage(name: changePassword, page: () => const ChangePassword()),
  ];
}
