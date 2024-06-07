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

  List<UserRes> _listResult = [];

  List<UserRes> get listResult {
    return _listResult;
  }

  bool _isPageLast = false;

  bool get isPageLast {
    return _isPageLast;
  }

  Future<int> getAllUser({int? pageIndex}) async {
    updateSearchKey(pageIndex ?? 1);
    Response response = await searchRepo.getAll(searchKey!);
    if (response.statusCode == 200) {
      for (var element in response.body["content"]) {
        var user = UserRes.fromJson(element);
        debugPrint('$user');
        _listResult.add(user);
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
  }

  void clearData() {
    _listResult = [];
  }
}
