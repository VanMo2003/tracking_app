class RoleBody {
  int? id;
  String? name;
  String? description;
  String? authority;

  RoleBody({this.id, this.name, this.description, this.authority});

  RoleBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['authority'] = authority;
    return data;
  }
}
