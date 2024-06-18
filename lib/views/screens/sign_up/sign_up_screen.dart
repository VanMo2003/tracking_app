import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/helper/snackbar_helper.dart';
import 'package:traking_app/models/body/user.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/screens/sign_up/enter_info_screen.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';
import '../../../helper/loading_helper.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/styles.dart';
import '../../widgets/text_field_widget.dart';

enum Gender { male, female }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            context,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      KeyLanguage.signUp.tr,
                      style: robotoBlack.copyWith(
                        fontSize: Dimensions.FONT_SIZE_TITLE_LARGE,
                        color: ColorResources.getBlackColor(),
                      ),
                    ),
                    const SizedBox(
                        height: Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
                    TextFieldWidget(
                      controller: _usernameController,
                      labelText: KeyLanguage.username.tr,
                      isPasswordField: false,
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
                    TextFieldWidget(
                      controller: _confirmPasswordController,
                      labelText: KeyLanguage.comfirmPassword.tr,
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
                    const SizedBox(
                        height: Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
                    GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: Container(
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: ColorResources.getPrimaryColor(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            KeyLanguage.signUp.tr,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(KeyLanguage.questionSignIn.tr),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            await animatedLoading();
                            Get.offNamed(RouteHelper.signIn);
                            animatedNoLoading();
                          },
                          child: Text(
                            KeyLanguage.signIn.tr,
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
      )),
    );
  }

  void signUp() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (!key.currentState!.validate()) {
    } else if (password != confirmPassword) {
      var snackBar =
          SnackBar(content: Text(KeyLanguage.errorPasswordsDuplicate.tr));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await animatedLoading();

      User user = User(
        username: username,
        password: password,
        confirmPassword: confirmPassword,
      );
      Get.find<AuthController>().registor(user).then(
        (value) {
          if (value == 200) {
            Get.find<AuthController>().login(username, password);
            Get.offAllNamed(RouteHelper.getEnterInfo());
          } else {
            showCustomSnackBar(KeyLanguage.errorAnUnknow.tr);
          }
        },
      );
    }
    animatedNoLoading();
  }
}
