class Role {
  int? id;
  String? name;
  String? description;
  String? authority;

  Role({this.id, this.name, this.description, this.authority});

  Role.fromJson(Map<String, dynamic> json) {
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
