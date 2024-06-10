import 'package:traking_app/models/response/user_res.dart';

class Likes {
  int? id;
  int? type;
  String? date;
  UserRes? user;
  Null? post;

  Likes({this.id, this.type, this.date, this.user, this.post});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    date = json['date'];
    user = json['user'] != null ? UserRes.fromJson(json['user']) : null;
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['post'] = post;
    return data;
  }
}
