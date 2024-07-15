import '../response/user_res.dart';

class Tracking {
  int? id;
  String? content;
  String? date;
  UserRes? user;

  Tracking({this.id, this.content, this.date, this.user});

  Tracking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    date = json['date'];
    user = json['user'] != null ? UserRes.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
