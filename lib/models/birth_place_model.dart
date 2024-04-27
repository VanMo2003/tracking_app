class BirthPlace {
  String? id;
  String? name;
  List<Districts>? districts;

  BirthPlace({this.id, this.name, this.districts});

  BirthPlace.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    if (json['Districts'] != null) {
      districts = <Districts>[];
      json['Districts'].forEach((v) {
        districts!.add(Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    if (districts != null) {
      data['Districts'] = districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  String? id;
  String? name;
  List<Wards>? wards;

  Districts({this.id, this.name, this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    if (json['Wards'] != null) {
      wards = <Wards>[];
      json['Wards'].forEach((v) {
        wards!.add(Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    if (wards != null) {
      data['Wards'] = wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  String? id;
  String? name;
  String? level;

  Wards({this.id, this.name, this.level});

  Wards.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    level = json['Level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Level'] = level;
    return data;
  }
}
