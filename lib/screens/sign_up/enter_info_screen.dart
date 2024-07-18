import 'dart:core';
import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/data/models/body/role.dart';
import 'package:traking_app/helper/date_converter_hepler.dart';
import 'package:traking_app/helper/validation_helper.dart';
import 'package:traking_app/screens/sign_up/sign_up_screen.dart';
import 'package:traking_app/views/custom_dialog_calendar.dart';
import '/controllers/auth_controller.dart';
import '/helper/loading_helper.dart';
import '../../data/models/response/user_res.dart';
import '../../views/custom_loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../helper/route_helper.dart';
import '../../views/custom_snackbar.dart';
import '../../utils/app_constant.dart';
import '../../utils/asset_util.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/language/key_language.dart';
import '../../utils/styles.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/text_field_widget.dart';

enum Gender { male, female }

extension GenderX on Gender {
  String get gender {
    switch (this) {
      case Gender.male:
        return "nam";
      case Gender.female:
        return "nữ";
      default:
        return "giới tính";
    }
  }
}

class EnterInfoScreent extends StatefulWidget {
  const EnterInfoScreent({
    super.key,
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  State<EnterInfoScreent> createState() => _EnterInfoScreentState();
}

class _EnterInfoScreentState extends State<EnterInfoScreent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  final key = GlobalKey<FormState>();

  String? selectedBirthPlace;
  RxString dob = DateConverter.dateToStringformat(DateTime.now()).obs;
  Gender? _character = Gender.male;

  late Calendar calendar;

  @override
  void initState() {
    super.initState();
    calendar = Calendar(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _displaynameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _universityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    AssetUtil.backgroundLogin,
                  ),
                  fit: BoxFit.cover,
                  opacity: Get.isDarkMode ? 0.5 : 1,
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
                            KeyLanguage.infoPerson.tr,
                            style: robotoBlack.copyWith(
                              fontSize: Dimensions.FONT_SIZE_TITLE_LARGE,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER),
                          TextFieldWidget(
                            controller: _emailController,
                            labelText: KeyLanguage.email.tr,
                            isPasswordField: false,
                            validator: (value) {
                              return ValidationHelper.validEmail(value);
                            },
                          ),
                          TextFieldWidget(
                            controller: _displaynameController,
                            labelText: KeyLanguage.displayName.tr,
                            isPasswordField: false,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldWidget(
                                  controller: _firstNameController,
                                  labelText: KeyLanguage.firstName.tr,
                                  isPasswordField: false,
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.SIZE_BOX_HEIGHT_DEFAULT,
                              ),
                              Expanded(
                                child: TextFieldWidget(
                                  controller: _lastNameController,
                                  labelText: KeyLanguage.lastName.tr,
                                  isPasswordField: false,
                                ),
                              ),
                            ],
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
                          Obx(() {
                            return TextFieldWidget(
                              controller:
                                  TextEditingController(text: dob.value),
                              labelText: KeyLanguage.dateOfBirth.tr,
                              isPasswordField: false,
                              validator: (value) {
                                return ValidationHelper.validDOB(value);
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  pickDOB();
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                            );
                          }),
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
                                    color: Theme.of(context).disabledColor,
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
                          ButtonPrimaryWidget(
                            label: KeyLanguage.completed.tr,
                            onTap: () {
                              completed();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void completed() async {
    String email = _emailController.text;
    String displayName = _displaynameController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String university = _universityController.text;

    if (key.currentState!.validate()) {
      if (selectedBirthPlace == null) {
        showCustomSnackBar(KeyLanguage.isNullBirthPlace.tr);
      } else {
        await animatedLoading();

        UserRes user = UserRes(
          username: widget.username,
          password: widget.password,
          confirmPassword: widget.password,
          email: email,
          displayName: displayName,
          firstName: firstName,
          lastName: lastName,
          university: university,
          birthPlace: selectedBirthPlace,
          gender: _character!.gender,
          dob: DateConverter.convertDateToTimestamp("2003-09-03"),
          roles: [],
        );

        Get.find<AuthController>().registor(user).then(
          (value) {
            if (value == 200) {
              Get.find<AuthController>()
                  .login(widget.username, widget.password)
                  .then(
                (value) {
                  if (value == 200) {
                    Get.offAllNamed(RouteHelper.getHomeUserRoute());
                    showCustomSnackBar(KeyLanguage.registorSuccess.tr,
                        isError: false);
                  }

                  animatedNoLoading();
                },
              );
            } else if (value == 401) {
              Get.offAll(SignUpScreent(user: user));
              animatedNoLoading();
            }
          },
        );
      }
    }
  }

  Future<void> pickDOB() async {
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: calendar.config(),
      dialogSize: const Size(325, 370),
      borderRadius: BorderRadius.circular(15),
      value: [
        DateConverter.dateTimeStringToDate(dob.value),
      ],
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (values != null) {
      dob.value = Calendar.getValueText(
        calendar.config().calendarType,
        values,
      );
    }
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ColorResources.getBlackColor().withOpacity(0.5),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold,
                color: ColorResources.getGreyColor(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.getBlackColor(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedBirthPlace,
          onChanged: (value) {
            setState(() {
              selectedBirthPlace = value;
            });
          },
          iconStyleData: IconStyleData(
            iconSize: Dimensions.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER,
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
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
        ),
      ),
    );
  }
}
