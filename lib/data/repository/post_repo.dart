import '../models/body/posts/comment.dart';
import '../models/body/posts/content.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';
import '/utils/app_constant.dart';

import '../models/body/search.dart';

class PostRepo {
  PostRepo({required this.apiClient});

  final ApiClient apiClient;

  Future<Response> getPosts(Search search) async {
    return await apiClient.postData(
      AppConstant.POSTS,
      search,
    );
  }

  Future<Response> getPostsByUser(Search search) async {
    return await apiClient.postData(
      AppConstant.POSTS_BY_USER,
      search,
    );
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
