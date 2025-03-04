import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traking_app/data/models/response/user_res.dart';
import 'package:traking_app/screens/sign_up/enter_info_screen.dart';
import '../../controllers/auth_controller.dart';
import '../../helper/validation_helper.dart';
import '/helper/route_helper.dart';
import '../../views/custom_snackbar.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import '../widgets/button_primary_widget.dart';
import '../../views/custom_loading.dart';
import '../../helper/loading_helper.dart';
import '../../utils/asset_util.dart';
import '../../utils/color_resources.dart';
import '../../utils/styles.dart';
import '../widgets/text_field_widget.dart';

enum Gender { male, female }

class SignUpScreent extends StatefulWidget {
  SignUpScreent({super.key, this.user});

  UserRes? user;

  @override
  State<SignUpScreent> createState() => _SignUpScreentState();
}

class _SignUpScreentState extends State<SignUpScreent> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _usernameController.text = widget.user!.username!;
      _passwordController.text = widget.user!.password!;
      _confirmPasswordController.text = widget.user!.confirmPassword!;
    }
  }

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
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              AssetUtil.backgroundLogin,
            ),
            fit: BoxFit.cover,
            opacity: Get.isDarkMode ? 0.3 : 1,
          ),
        ),
        child: Center(
          child: LoadingWidget(
            child: Padding(
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
                        return ValidationHelper.validPassword(value);
                      },
                    ),
                    TextFieldWidget(
                      controller: _confirmPasswordController,
                      labelText: KeyLanguage.comfirmPassword.tr,
                      isPasswordField: true,
                      validator: (value) {
                        return ValidationHelper.validPassword(value);
                      },
                    ),
                    const SizedBox(
                        height: Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
                    ButtonPrimaryWidget(
                      label: KeyLanguage.signUp.tr,
                      onTap: () {
                        signUp();
                      },
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
    );
  }

  void signUp() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (!key.currentState!.validate()) {
    } else if (password != confirmPassword) {
      showCustomSnackBar(KeyLanguage.errorPasswordsDuplicate.tr);
    } else {
      await animatedLoading();
      if (widget.user == null) {
        Get.offAll(EnterInfoScreent(username: username, password: password));
        animatedNoLoading();
      } else {
        widget.user = widget.user!.copyWith(
          username: username,
          password: password,
          confirmPassword: confirmPassword,
        );
        Get.find<AuthController>().registor(widget.user!).then(
          (value) {
            if (value == 200) {
              Get.find<AuthController>()
                  .login(widget.user!.username!, widget.user!.password!)
                  .then(
                (value) {
                  if (value == 200) {
                    Get.offAllNamed(RouteHelper.getHomeUserRoute());
                    showCustomSnackBar(KeyLanguage.registorSuccess.tr,
                        isError: false);
                  }
                },
              );
            }
            animatedNoLoading();
          },
        );
      }
    }
  }
}
