import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/models/body/search_body.dart';
import 'package:traking_app/networks/repository/search_repo.dart';
import 'package:traking_app/utils/dimensions.dart';

import '../models/response/user_res.dart';

class SearchByPageController extends GetxController implements GetxService {
  final SearchRepo searchRepo;

  SearchByPageController({required this.searchRepo}) {
    searchKey = SearchBody(
      keyWord: "",
      pageIndex: 1,
      size: Dimensions.SIZE_OF_PAGE,
      status: 0,
    );
  }

  SearchBody? searchKey;

  List<UserRes> listResult = [];

  List<UserRes>? get list {
    return listResult;
  }

  Future<int> getAllUser() async {
    Response response = await searchRepo.getAll(searchKey!);
    if (response.statusCode == 200) {
      for (var element in response.body["content"]) {
        var user = UserRes.fromJson(element);
        debugPrint('$user');
        listResult.add(user);
      }
    } else if (response.statusCode == 401) {
      clearData();
    } else {
      clearData();
    }
    update();
    return response.statusCode!;
  }

  void updateSearchKey(int pageIndex) {
    searchKey = SearchBody(
      keyWord: "",
      pageIndex: pageIndex,
      size: Dimensions.SIZE_OF_PAGE,
      status: 0,
    );
    update();
  }

  void clearData() {
    listResult = [];
  }
}
