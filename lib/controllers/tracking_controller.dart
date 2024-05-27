import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/models/body/tracking_model.dart';
import 'package:traking_app/networks/repository/tracking_repo.dart';

import '../helper/snackbar_helper.dart';

class TrackingController extends GetxController implements GetxService {
  final TrackingRepo trackingRepo;

  TrackingController({required this.trackingRepo});

  List<TrackingBody> _list = [];
  List<TrackingBody> get list {
    sortByDateDesc();
    return _list;
  }

  Future<int> getAllByUser() async {
    Response response = await trackingRepo.getAllByUser();
    if (response.statusCode == 200) {
      clearData();
      debugPrint('${response.body}');
      for (var element in response.body) {
        var tracking = TrackingBody.fromJson(element);
        _list.add(tracking);
      }
    } else if (response.statusCode == 401) {
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }

    update();
    return response.statusCode!;
  }

  Future<int> addTracking(TrackingBody tracking) async {
    Response response = await trackingRepo.addTracking(tracking);
    if (response.statusCode == 200) {
      var tracking = TrackingBody.fromJson(response.body);
      _list.add(tracking);
    } else if (response.statusCode == 401) {
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }

    update();
    return response.statusCode!;
  }

  Future<int> updateTracking(TrackingBody tracking) async {
    Response response = await trackingRepo.updateTracking(tracking);
    if (response.statusCode == 200) {
      var tracking = TrackingBody.fromJson(response.body);
      _list.removeWhere(
        (element) => element.id == tracking.id,
      );
      _list.add(tracking);
    } else if (response.statusCode == 401) {
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }

    update();
    return response.statusCode!;
  }

  Future<int> deleteTracking(TrackingBody tracking) async {
    Response response = await trackingRepo.deleteTracking(tracking);
    if (response.statusCode == 200) {
      _list.removeWhere(
        (element) => element.id == tracking.id,
      );
    } else if (response.statusCode == 401) {
      clearData();
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }

    update();
    return response.statusCode!;
  }

  void sortByDateDesc() {
    _list.sort(
      (a, b) {
        if (a.date!.compareTo(b.date ?? DateTime.now().toString()) < 0) {
          return 1;
        }
        return -1;
      },
    );
  }

  void clearData() {
    _list = [];
  }
}
