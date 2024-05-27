import 'package:traking_app/models/body/tracking_model.dart';
import 'package:traking_app/networks/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/app_constant.dart';

class TrackingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TrackingRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllByUser() async {
    return await apiClient.getData(AppConstant.TRACKING);
  }

  Future<Response> addTracking(TrackingBody tracking) async {
    return await apiClient.postData(AppConstant.TRACKING, tracking);
  }

  Future<Response> deleteTracking(TrackingBody tracking) async {
    return await apiClient.deleteData(AppConstant.TRACKING, id: tracking.id);
  }

  Future<Response> updateTracking(TrackingBody tracking) async {
    return await apiClient.postData(
      "${AppConstant.TRACKING}/${tracking.id}",
      tracking,
    );
  }
}
