import 'package:get/get.dart';
import 'package:traking_app/controllers/loading_controller.dart';

Future<void> animatedLoading() async {
  Get.find<LoadingController>().loading();
  await Future.delayed(
    const Duration(milliseconds: 1000),
    () {},
  );
}

Future<void> animatedNoLoading() async {
  Get.find<LoadingController>().noLoading();
}
