import 'package:traking_app/views/screens/home/role_admin/home_admin_screen.dart';
import 'package:traking_app/views/screens/home/role_user/drawer/screens/post/post_screen.dart';
import 'package:traking_app/views/screens/home/role_user/drawer/screens/info_user_screen.dart';
import 'package:traking_app/views/screens/home/role_user/home_user_screen.dart';
import 'package:traking_app/views/screens/sign_in/sign_in_screen.dart';
import 'package:traking_app/views/screens/sign_up/enter_info_screen.dart';
import 'package:traking_app/views/screens/sign_up/sign_up_screen.dart';

import '../views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String enterInfo = "/enter-info";
  static const String home = "/home";
  static const String homeAdmin = "/home_admin";
  static const String infoUser = "/info_user";
  static const String changePassword = "/change_password";
  static const String post = "/post";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getEnterInfo() => enterInfo;
  static String getHomeRoute() => home;
  static String getHomeAdminRoute() => homeAdmin;
  static String getInfoUserRoute() => infoUser;
  static String getChangePassword() => changePassword;
  static String getPostRoute() => post;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: enterInfo, page: () => EnterInfoScreen()),
    GetPage(name: home, page: () => const HomeUserScreent()),
    GetPage(name: homeAdmin, page: () => const HomeAdminScreent()),
    GetPage(name: infoUser, page: () => const InfoUserScreen()),
    GetPage(name: post, page: () => const PostScreen()),
  ];
}
