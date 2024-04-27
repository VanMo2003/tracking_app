import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/models/user_model.dart';
import 'package:traking_app/services/birth_place_service.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/radio_button_gender.dart';

import '../../controllers/loading_controller.dart';
import '../../helper/loading_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/styles.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _comfirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  var isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _comfirmPasswordController.dispose();
    _fullNameController.dispose();
    _universityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var safePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safePadding),
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        KeyLanguage.signUp.tr,
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
                      TextFieldWidget(
                        controller: _comfirmPasswordController,
                        labelText: KeyLanguage.comfirmPassword.tr,
                        isPasswordField: true,
                      ),
                      TextFieldWidget(
                        controller: _fullNameController,
                        labelText: KeyLanguage.fullname.tr,
                        isPasswordField: false,
                      ),
                      TextFieldWidget(
                        controller: _universityController,
                        labelText: KeyLanguage.university.tr,
                        isPasswordField: false,
                      ),
                      CategoriesDropDown(
                        labelText: KeyLanguage.birthPlace.tr,
                        items: BirthPlaceService.birthPlaces,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_SMALL,
                            left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Giới tính : ",
                              style: TextStyle(
                                color: ColorResources.getBlackColor(),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: RadioGender(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          await animatedLoading();
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
                                  fontSize: 18, color: Colors.white),
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
                GetBuilder<LoadingController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.isLoading,
                      child: Container(
                        color: Colors.white.withOpacity(0.4),
                        child: Center(child: loading),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    User user = User(
      birthPlace: "Thái Bình",
      username: "Van123",
      password: "123",
      confirmPassword: "123",
      email: "xuanvan39@gmail.com",
      displayName: "Xuân Văn",
      firstName: "Phạm",
      lastName: "Xuân Văn",
      gender: "Nam",
      university: "HAU",
      year: 21,
    );
    Get.find<AuthController>().registor(user);
  }
}
