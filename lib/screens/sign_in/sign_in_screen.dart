import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/screens/widgets/dropdown_language_widget.dart';
import 'package:traking_app/screens/widgets/switch_widget.dart';
import '/controllers/auth_controller.dart';
import '/helper/route_helper.dart';
import '/utils/asset_util.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import '../widgets/button_primary_widget.dart';

import '../../helper/loading_helper.dart';
import '../../utils/styles.dart';
import '../../views/custom_loading.dart';
import '../widgets/text_field_widget.dart';

class SignInScreent extends StatefulWidget {
  const SignInScreent({super.key});

  @override
  State<SignInScreent> createState() => _SignInScreentState();
}

class _SignInScreentState extends State<SignInScreent> {
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
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  AssetUtil.backgroundLogin,
                ),
                opacity: Get.isDarkMode ? 0.5 : 1,
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: LoadingWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          KeyLanguage.signIn.tr,
                          style: robotoBlack.copyWith(
                            fontSize: Dimensions.FONT_SIZE_TITLE_LARGE,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        const SizedBox(
                            height:
                                Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
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
                        const SizedBox(
                            height:
                                Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
                        ButtonPrimaryWidget(
                          label: KeyLanguage.signIn.tr,
                          onTap: () {
                            login();
                          },
                        ),
                        const SizedBox(
                            height:
                                Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER *
                                    2 /
                                    3),
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
                                  color: Theme.of(context)
                                      .primaryColor
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
          Positioned(
            top: top,
            left: Dimensions.PADDING_SIZE_LARGE,
            child: const DropdownLangueWidget(),
          ),
          Positioned(
            top: top,
            right: Dimensions.PADDING_SIZE_LARGE,
            child: const SwitchWidget(),
          ),
        ],
      ),
    );
  }

  void login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (key.currentState!.validate()) {
      await animatedLoading();

      await Get.find<AuthController>().login(username, password).then(
        (value) async {
          if (value == 200) {
            await Get.find<AuthController>().getCurrentUser();
            if (Get.find<AuthController>().isAdmin) {
              Get.offAllNamed(RouteHelper.getHomeAdminRoute());
            } else {
              Get.offAllNamed(RouteHelper.getHomeUserRoute());
            }
          }
        },
      );
      animatedNoLoading();
    }
  }
}
