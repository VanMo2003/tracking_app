import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/utils/color_resources.dart';
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

  bool _isError = false;
  String? error;

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
            child: loading(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                    ),
                    TextFieldWidget(
                      controller: _passwordController,
                      labelText: KeyLanguage.password.tr,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        await animatedLoading();
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
                            Get.find<LoadingController>().noLoading();
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
                    if (_isError) ...[
                      const SizedBox(height: 10),
                      Text(
                        error!,
                      )
                    ]
                  ],
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

    if (username.isEmpty || password.isEmpty) {
      var snackBar = SnackBar(content: Text(KeyLanguage.errorFillInAllInfo.tr));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
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
    }
    Get.find<LoadingController>().noLoading();
  }
}
