import '../../response/user_res.dart';

class Comments {
  int? id;
  String? content;
  Null? post;
  int? date;
  UserRes? user;

  Comments({this.id, this.content, this.post, this.date, this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    post = json['post'];
    date = json['date'];
    user = json['user'] != null ? UserRes.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['post'] = post;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
