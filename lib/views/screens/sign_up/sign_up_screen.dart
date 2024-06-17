import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/models/body/user.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../controllers/loading_controller.dart';
import '../../../helper/loading_helper.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/styles.dart';
import '../../../helper/widgets/text_field_widget.dart';

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

  final key = GlobalKey<FormState>();

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
        margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_LARGE),
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
                            height:
                                Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
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
                          controller: _comfirmPasswordController,
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
                        TextFieldWidget(
                          controller: _emailController,
                          labelText: KeyLanguage.email.tr,
                          isPasswordField: false,
                          validator: (value) {
                            if (GetUtils.isNull(value != "" ? value : null)) {
                              return KeyLanguage.validNull.tr;
                            }
                            if (!GetUtils.isEmail(value!)) {
                              return KeyLanguage.validEmail.tr;
                            }
                            return null;
                          },
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
                        birthPlaceDropdown(
                          AppConstant.birthPlaces,
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
                                "${KeyLanguage.gender.tr} : ",
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
                        const SizedBox(
                            height:
                                Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
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

  void signUp() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String comfirmPassword = _comfirmPasswordController.text;
    String email = _emailController.text;
    String displayName = _displaynameController.text;
    String fullname = _fullNameController.text;
    String university = _universityController.text;
    String age = _yearOldController.text;

    if (!key.currentState!.validate()) {
    } else if (password != comfirmPassword) {
      var snackBar =
          SnackBar(content: Text(KeyLanguage.errorPasswordsDuplicate.tr));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await animatedLoading();

      User user = User(
        birthPlace: selectedBirthPlace,
        username: username,
        password: password,
        confirmPassword: comfirmPassword,
        email: email,
        displayName: displayName,
        firstName: splitFirstName(fullname),
        lastName: splitLastName(fullname),
        gender: _character == Gender.male
            ? KeyLanguage.male.tr
            : KeyLanguage.female.tr,
        university: university,
        year: int.parse(age),
      );
      Get.find<AuthController>().registor(user);
    }
    animatedNoLoading();
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
            title: Text(KeyLanguage.male.tr),
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
            title: Text(KeyLanguage.female.tr),
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
              Icon(
                Icons.list,
                size: 18,
                color: ColorResources.getBlackColor(),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  labelText,
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.getBlackColor(),
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
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
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
                color: ColorResources.getBlackColor().withOpacity(0.5),
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
