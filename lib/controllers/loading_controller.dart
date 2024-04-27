import 'package:get/get.dart';

class LoadingController extends GetxController implements GetxService {
  LoadingController({this.isLoading = false});

  bool isLoading;

  void loading() {
    isLoading = true;
    update();
  }

  void noLoading() {
    isLoading = false;
    update();
  }
}
