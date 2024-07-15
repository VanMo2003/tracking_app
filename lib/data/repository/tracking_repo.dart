import '../api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '/utils/app_constant.dart';

import '../models/body/tracking.dart';

class TrackingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TrackingRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllByUser() async {
    return await apiClient.getData(AppConstant.TRACKING);
  }

  Future<Response> addTracking(Tracking tracking) async {
    return await apiClient.postData(AppConstant.TRACKING, tracking);
  }

  Future<Response> deleteTracking(Tracking tracking) async {
    return await apiClient.deleteData(AppConstant.TRACKING, id: tracking.id);
  }

  Future<Response> updateTracking(Tracking tracking) async {
    return await apiClient.postData(
      "${AppConstant.TRACKING}/${tracking.id}",
      tracking,
    );
  }
}
