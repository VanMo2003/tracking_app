import 'package:flutter/material.dart';
import 'package:traking_app/helper/route_helper.dart';
import '/controllers/auth_controller.dart';
import '/helper/date_converter_hepler.dart';
import '/helper/loading_helper.dart';
import '../widgets/button_drawer_widget.dart';
import '../../data/models/response/user_res.dart';
import '/utils/color_resources.dart';
import '/utils/dimensions.dart';
import '/utils/asset_util.dart';
import '/utils/language/key_language.dart';
import 'package:get/get.dart';
import '/utils/styles.dart';
import '../../views/custom_loading.dart';

import '../../views/custom_snackbar.dart';
import '../widgets/dialog_widget.dart';

class DetailUserScreent extends StatefulWidget {
  DetailUserScreent({super.key, UserRes? user}) : _user = user ?? UserRes();

  final UserRes _user;

  @override
  State<DetailUserScreent> createState() => _DetailUserScreentState();
}

class _DetailUserScreentState extends State<DetailUserScreent> {
  TextEditingController displaynameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var safePaddingTop = MediaQuery.of(context).padding.top;
    return LoadingWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      image: widget._user.image != null
                          ? NetworkImage(widget._user.image!)
                          : const AssetImage(AssetUtil.image),
                      scale: 0.3,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.4 - Dimensions.RADIUS_EXTRA_LARGE,
                ),
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                height: size.height * 0.6 + Dimensions.RADIUS_EXTRA_LARGE,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                  ),
                  color: ColorResources.getWhiteColor(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "(${widget._user.firstName ?? "Họ"}${widget._user.lastName ?? " và tên"})",
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      "${KeyLanguage.displayName.tr} : ${widget._user.displayName ?? KeyLanguage.displayName.tr}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    ),
                    Text(
                      "${KeyLanguage.dateOfBirth.tr} : ${widget._user.dob ?? DateConverter.dateTimeStringToDateOnly(DateTime.now().toString())}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    ),
                    Text(
                      "${KeyLanguage.birthPlace.tr} : ${widget._user.birthPlace ?? "Hà Nội"}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    ),
                    Text(
                      "${KeyLanguage.university.tr} : ${widget._user.university ?? "Oceantech"}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    ),
                    Text(
                      "${KeyLanguage.gender.tr} : ${widget._user.gender ?? "${KeyLanguage.male.tr}/${KeyLanguage.female.tr}"}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                    ),
                    Text(
                      "${KeyLanguage.status.tr} : ${widget._user.active! ? KeyLanguage.active.tr : KeyLanguage.noActive.tr}",
                      style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          color: widget._user.active!
                              ? ColorResources.getAddMoneyCardColor()
                              : ColorResources.getRedColor()),
                    ),
                    if (Get.find<AuthController>().isAdmin) ...[
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.PADDING_SIZE_DEFAULT),
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonDrawerWidget(
                                onTap: () {
                                  edit();
                                },
                                label: KeyLanguage.edit.tr,
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_DEFAULT),
                            Expanded(
                              child: widget._user.active!
                                  ? ButtonDrawerWidget(
                                      onTap: () {
                                        lock(context);
                                      },
                                      label: KeyLanguage.lock.tr,
                                      icon: const Icon(Icons.lock_outline),
                                    )
                                  : ButtonDrawerWidget(
                                      onTap: () {
                                        debugPrint('click unlock');
                                      },
                                      label: KeyLanguage.unlock.tr,
                                      icon: const Icon(Icons.lock_open_rounded),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: safePaddingTop,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void edit() {
    showDialog(
      context: context,
      builder: (context) {
        displaynameController.text = widget._user.displayName!;
        birthPlaceController.text = widget._user.birthPlace ?? "Hà Nội";
        universityController.text = widget._user.university ?? "Oceantech";
        dateOfBirthController.text = DateConverter.dateTimeStringToDateOnly(
            widget._user.dob ?? DateTime.now().toString());
        return dialogUpdateWidget(
          context,
          child: Column(
            children: [
              TextFormField(
                controller: displaynameController,
                decoration: InputDecoration(
                  hintText: KeyLanguage.displayName.tr,
                ),
              ),
              TextFormField(
                controller: birthPlaceController,
                decoration: InputDecoration(
                  hintText: KeyLanguage.birthPlace.tr,
                ),
              ),
              TextFormField(
                controller: universityController,
                decoration: InputDecoration(
                  hintText: KeyLanguage.university.tr,
                ),
              ),
              TextFormField(
                controller: dateOfBirthController,
                decoration: InputDecoration(
                  hintText: KeyLanguage.dateOfBirth.tr,
                ),
              ),
            ],
          ),
          opTap: () async {
            UserRes user = widget._user;
            user.displayName = displaynameController.text;
            user.birthPlace = birthPlaceController.text;
            user.university = universityController.text;
            user.dob = DateConverter.dateTimeStringToDateTime(
                birthPlaceController.text);

            Get.find<AuthController>().updateInfoUser(user);
          },
        );
      },
    );
  }

  void lock(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => dialogQuestionWidget(
        context,
        KeyLanguage.lock.tr,
        "${KeyLanguage.lockQuestion.tr} (${widget._user.displayName})?",
        () async {
          await animatedLoading();
          await Get.find<AuthController>().lock(widget._user.id!).then(
            (value) {
              if (value == 200) {
                showCustomSnackBar(
                  "${KeyLanguage.lock.tr} : ${widget._user.displayName}",
                  isError: false,
                );
                setState(() {});
              }
            },
          );
          animatedNoLoading();
        },
      ),
    );
  }
}
