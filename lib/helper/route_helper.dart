import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:traking_app/views/screens/home_user/post/add_post_screen.dart';

import '../views/screens/home_admin/home_admin_screen.dart';
import '../views/screens/home_user/post/post_screen.dart';
import '../views/screens/home_user/info_user/info_user_screen.dart';
import '../views/screens/home_user/home_user_screen.dart';
import 'package:traking_app/views/screens/sign_in/sign_in_screen.dart';
import 'package:traking_app/views/screens/sign_up/enter_info_screen.dart';
import 'package:traking_app/views/screens/sign_up/sign_up_screen.dart';

import '../message.dart';
import '../views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String enterInfo = "/enter-info";
  static const String home = "/home";
  static const String homeAdmin = "/home-admin";
  static const String infoUser = "/info-user";
  static const String changePassword = "/change-password";
  static const String post = "/post";
  static const String addPost = "/add_post";
  static const String message = "/message";

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
  static String getAddPostRoute() => addPost;
  static String getMessage() => message;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreent()),
    GetPage(name: signIn, page: () => const SignInScreent()),
    GetPage(name: signUp, page: () => const SignUpScreent()),
    GetPage(name: enterInfo, page: () => const EnterInfoScreent()),
    GetPage(name: home, page: () => const HomeUserScreent()),
    GetPage(name: homeAdmin, page: () => const HomeAdminScreent()),
    GetPage(name: infoUser, page: () => const InfoUserScreent()),
    GetPage(name: post, page: () => const PostScreent()),
    GetPage(name: addPost, page: () => AddPostScreent()),
    GetPage(name: message, page: () => const MessageScreent()),
  ];
}
