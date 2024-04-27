import 'package:traking_app/views/screens/home_screen.dart';
import 'package:traking_app/views/screens/sign_in_screen.dart';
import 'package:traking_app/views/screens/sign_up_screen.dart';

import '../views/screens/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String home = "/home";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getHomeRoute() => home;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
