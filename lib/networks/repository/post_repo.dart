import 'package:traking_app/models/body/posts/comment.dart';
import 'package:traking_app/models/body/posts/content.dart';
import 'package:traking_app/networks/api/api_client.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/app_constant.dart';

import '../../models/body/search.dart';

class PostRepo {
  PostRepo({required this.apiClient});

  final ApiClient apiClient;

  Future<Response> getPosts(Search search) async {
    return await apiClient.postData(AppConstant.POSTS, search);
  }

  Future<Response> addContent(Content content) async {
    return await apiClient.postData(AppConstant.ADD_POST, content);
  }

  Future<Response> likePost(int id) async {
    return await apiClient.postData("${AppConstant.LIKE_POST}/$id", {});
  }

  Future<Response> commentPost(int id, Comments body) async {
    return await apiClient.postData("${AppConstant.COMMENT_POST}/$id", body);
  }
}
