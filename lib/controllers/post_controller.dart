import 'package:get/get.dart';
import 'package:traking_app/helper/snackbar_helper.dart';
import 'package:traking_app/models/body/posts/comment.dart';
import 'package:traking_app/models/body/posts/like.dart';
import 'package:traking_app/models/body/posts/post.dart';
import 'package:traking_app/models/body/search.dart';
import 'package:traking_app/networks/repository/post_repo.dart';
import 'package:traking_app/utils/dimensions.dart';

import '../models/body/posts/content.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo repo;
  PostController({required this.repo})
      : _search = Search(
          keyWord: "",
          pageIndex: 1,
          size: Dimensions.SIZE_OF_PAGE_POSTS,
          status: 0,
        );

  Posts? _posts;
  Search _search;
  List<Content> _contents = [];
  // List<Comments> _comments = [];

  Posts? get posts => _posts;
  Search get search => _search;
  List<Content> get contents => _contents;
  // List<Comments> get comments => _comments;

  Future<int> getPosts({int? pageIndex}) async {
    if (pageIndex != 1) {
      updateSearchKey(pageIndex ?? 1);
    }
    Response response = await repo.getPosts(search);
    if (response.statusCode == 200) {
      _posts = Posts.fromJson(response.body);
      for (var element in _posts!.content!) {
        _contents.add(element);
      }
    } else {}

    update();
    return response.statusCode!;
  }

  Future<int> addContent(Content content) async {
    Response response = await repo.addContent(content);
    if (response.statusCode == 200) {
      showCustomSnackBar("Thêm thành công bài viết : ${content.content}");
    } else {}

    update();
    return response.statusCode!;
  }

  Future<int> likePost(int id) async {
    Response response = await repo.likePost(id);
    if (response.statusCode == 200) {
      var content = _contents.singleWhere(
        (element) => element.id == id,
      );
      content.likes ??= [];
      content.likes!.add(Likes.fromJson(response.body));
    } else {}

    update();
    return response.statusCode!;
  }

  Future<int> commentPost(int id, Comments body) async {
    Response response = await repo.commentPost(id, body);
    if (response.statusCode == 200) {
      var content = _contents.singleWhere(
        (element) => element.id == id,
      );
      content.comments ??= [];
      content.comments!.add(Comments.fromJson(response.body));
    } else {}

    update();
    return response.statusCode!;
  }

  void updateSearchKey(int pageIndex) {
    _search = Search(
      keyWord: "",
      pageIndex: pageIndex,
      size: Dimensions.SIZE_OF_PAGE_POSTS,
      status: 0,
    );
  }

  void clearData() {
    _posts = null;
    _contents = [];
  }
}
