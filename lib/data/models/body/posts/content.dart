import 'media.dart';
import '../../response/user_res.dart';

import 'comment.dart';
import 'like.dart';

class Content {
  int? id;
  String? content;
  int? date;
  UserRes? user;
  Media? media;
  List<Likes>? likes;
  List<Comments>? comments;

  Content(
      {this.id,
      this.content,
      this.date,
      this.user,
      this.media,
      this.likes,
      this.comments});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    date = json['date'];
    user = json['user'] != null ? UserRes.fromJson(json['user']) : null;
    media = json['media'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['media'] = media;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
