import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';

import '../../../helper/loading_helper.dart';
import '../../../utils/styles.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Center(
            child: loadingWidget(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        KeyLanguage.signIn.tr,
                        style: robotoBold.copyWith(
                          fontSize: 40,
                          color: ColorResources.getBlackColor(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFieldWidget(
                        controller: _usernameController,
                        labelText: KeyLanguage.username.tr,
                        isPasswordField: false,
                        validator: (value) {
                          if (GetUtils.isNull(value != "" ? value : null)) {
                            return KeyLanguage.validNull.tr;
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        controller: _passwordController,
                        labelText: KeyLanguage.password.tr,
                        isPasswordField: true,
                        validator: (value) {
                          if (GetUtils.isNull(value != "" ? value : null)) {
                            return KeyLanguage.validNull.tr;
                          }
                          if (!GetUtils.isLengthBetween(
                            value!,
                            Dimensions.MIN_LENGTH_PASSWORD,
                            Dimensions.MAX_LENGTH_PASSWORD,
                          )) {
                            return KeyLanguage.validPassword.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          login();
                        },
                        child: Container(
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: ColorResources.getPrimaryColor(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              KeyLanguage.signIn.tr,
                              style: robotoMedium.copyWith(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(KeyLanguage.questionSignUp.tr),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () async {
                              await animatedLoading();
                              Get.offNamed(RouteHelper.signUp);
                              animatedNoLoading();
                            },
                            child: Text(
                              KeyLanguage.signUp.tr,
                              style: TextStyle(
                                color: ColorResources.getPrimaryColor()
                                    .withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (!key.currentState!.validate()) {
    } else {
      await animatedLoading();
      await Get.find<AuthController>().login(username, password).then(
        (value) {
          if (value == 200) {
            Get.offAllNamed(RouteHelper.getHomeRoute());
          } else if (value == 400) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(KeyLanguage.errorWrongUsernameOrPassword.tr),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(KeyLanguage.errorAnUnknow.tr),
              ),
            );
          }
        },
      );
      animatedNoLoading();
    }
  }
}
