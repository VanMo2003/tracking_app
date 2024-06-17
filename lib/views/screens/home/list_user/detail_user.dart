import 'package:flutter/material.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/helper/date_converter.dart';
import 'package:traking_app/helper/loading_helper.dart';
import 'package:traking_app/helper/widgets/button_widget.dart';
import 'package:traking_app/helper/widgets/loading_widget.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/icons.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/styles.dart';

import '../../../../../helper/snackbar_helper.dart';
import '../../../../../helper/widgets/dialog_widget.dart';

class DetailUserScreen extends StatefulWidget {
  DetailUserScreen({super.key, UserRes? user}) : _user = user ?? UserRes();

  final UserRes _user;

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  TextEditingController displaynameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var safePaddingTop = MediaQuery.of(context).padding.top;
    return loadingWidget(
      Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    color: ColorResources.getPrimaryColor(),
                    image: DecorationImage(
                      image: widget._user.image != null
                          ? NetworkImage(widget._user.image!)
                          : const AssetImage(IconUtil.image),
                      scale: 0.4,
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
                          fontSize: Dimensions.FONT_SIZE_OVER_OVER_LARGE),
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
                      "${KeyLanguage.gender.tr} : ${widget._user.gender ?? "Nam/Nữ"}",
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
                              child: ButtonCustomWidget(
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
                                  ? ButtonCustomWidget(
                                      onTap: () {
                                        lock(context);
                                      },
                                      label: KeyLanguage.lock.tr,
                                      icon: const Icon(Icons.lock_outline),
                                    )
                                  : ButtonCustomWidget(
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
        return showDialogUpdate(
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
            ],
          ),
          opTap: () async {
            UserRes user = widget._user;
            user.displayName = displaynameController.text;
            user.birthPlace = birthPlaceController.text;
            user.university = universityController.text;

            await Get.find<AuthController>().updateInfoUser(user);
          },
        );
      },
    );
  }

  void lock(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => showDialogQuestion(
        context,
        "Khóa tài khoản?",
        "Bạn có chắc chắn khóa tài khoản (${widget._user.displayName})?",
        () async {
          await animatedLoading();
          await Get.find<AuthController>().lock(widget._user.id!).then(
            (value) {
              if (value == 200) {
                showCustomSnackBar(
                  "Khóa tài khoản : ${widget._user.displayName}",
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
