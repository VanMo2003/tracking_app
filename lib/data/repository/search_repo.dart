import 'package:get/get.dart';

import '../models/body/search.dart';
import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class SearchRepo {
  final ApiClient apiClient;

  SearchRepo({required this.apiClient});

  Future<Response> getAll(Search search) async {
    return await apiClient.postData(AppConstant.GET_ALL_USER, search);
  }
}
