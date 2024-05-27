import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/models/body/user_body.dart';
import 'package:traking_app/services/birth_place_service.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/radio_button_gender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../controllers/loading_controller.dart';
import '../../../helper/loading_helper.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/styles.dart';
import '../../widgets/loading_widget.dart';
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
  final TextEditingController _comfirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _yearOldController = TextEditingController();

  var isLoading = false.obs;

  String? selectedBirthPlace;
  Gender? _character = Gender.male;

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
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: safePadding),
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
                        controller: _emailController,
                        labelText: KeyLanguage.email.tr,
                        isPasswordField: false,
                      ),
                      TextFieldWidget(
                        controller: _displaynameController,
                        labelText: KeyLanguage.displayName.tr,
                        isPasswordField: false,
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
                      TextFieldWidget(
                        controller: _yearOldController,
                        labelText: KeyLanguage.age.tr,
                        isPasswordField: false,
                      ),
                      birthPlaceDropdown(
                        BirthPlaceService.birthPlaces,
                        KeyLanguage.birthPlace.tr,
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
                            SizedBox(
                              height: 70,
                              width: double.infinity,
                              child: radioGender(),
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
                              Get.find<LoadingController>().noLoading();
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
                      child: Positioned(
                        bottom: 0,
                        child: Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.white.withOpacity(0.4),
                          child: Center(
                            child: SpinKitSquareCircle(
                              color: ColorResources.getPrimaryColor(),
                              size: 50.0,
                            ),
                          ),
                        ),
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
    String username = _usernameController.text;
    String password = _passwordController.text;
    String comfirmPassword = _comfirmPasswordController.text;
    String email = _emailController.text;
    String displayName = _displaynameController.text;
    String fullname = _fullNameController.text;
    String university = _universityController.text;
    String age = _yearOldController.text;

    if (username.isEmpty ||
        password.isEmpty ||
        comfirmPassword.isEmpty ||
        comfirmPassword.isEmpty ||
        email.isEmpty ||
        displayName.isEmpty ||
        fullname.isEmpty ||
        university.isEmpty ||
        age.isEmpty) {
      var snackBar = SnackBar(content: Text(KeyLanguage.errorFillInAllInfo.tr));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password != comfirmPassword) {
      var snackBar =
          SnackBar(content: Text(KeyLanguage.errorPasswordsDuplicate.tr));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      UserBody user = UserBody(
        birthPlace: selectedBirthPlace,
        username: username,
        password: password,
        confirmPassword: comfirmPassword,
        email: email,
        displayName: displayName,
        firstName: splitFirstName(fullname),
        lastName: splitLastName(fullname),
        gender: _character == Gender.male ? "Nam" : "Nữ",
        university: university,
        year: int.parse(age),
      );
      Get.find<AuthController>().registor(user);
    }
    Get.find<LoadingController>().noLoading();
  }

  String splitFirstName(String fullname) {
    var indexFirstSpace = fullname.indexOf(" ");
    return fullname.substring(0, indexFirstSpace);
  }

  String splitLastName(String fullname) {
    var indexFirstSpace = fullname.indexOf(" ");
    return fullname.substring(indexFirstSpace + 1, fullname.length);
  }

  Widget radioGender() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Nam'),
            leading: Radio<Gender>(
              value: Gender.male,
              groupValue: _character,
              onChanged: (Gender? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Nữ'),
            leading: Radio<Gender>(
              value: Gender.female,
              groupValue: _character,
              onChanged: (Gender? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget birthPlaceDropdown(List<String> items, String labelText) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(
                Icons.list,
                size: 18,
                color: Colors.black,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  labelText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.getBlackColor(),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedBirthPlace,
          onChanged: (value) {
            setState(() {
              selectedBirthPlace = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 180,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: ColorResources.getWhiteColor(),
            ),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: ColorResources.getBlackColor(),
            iconDisabledColor: ColorResources.getGreyColor(),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.getWhiteColor(),
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
          // menuItemStyleData: const MenuItemStyleData(
          //   height: 40,
          //   padding: EdgeInsets.only(left: 14, right: 14),
          // ),
        ),
      ),
    );
  }
}
