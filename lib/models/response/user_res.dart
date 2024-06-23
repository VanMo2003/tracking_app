import 'package:traking_app/models/body/role.dart';

class UserRes {
  int? id;
  String? displayName;
  String? username;
  String? password;
  String? confirmPassword;
  bool? changePass;
  bool? active;
  String? lastName;
  String? firstName;
  String? dob;
  String? birthPlace;
  String? email;
  bool? hasPhoto;
  List<Role>? roles;
  String? gender;
  String? university;
  int? year;
  int? countDayCheckin;
  int? countDayTracking;
  String? tokenDevice;
  String? image;
  bool? setPassword;

  UserRes({
    this.id,
    this.displayName,
    this.username,
    this.password,
    this.confirmPassword,
    this.changePass = false,
    this.active = true,
    this.lastName,
    this.firstName,
    this.dob,
    this.birthPlace,
    this.email,
    this.hasPhoto = false,
    this.roles,
    this.gender,
    this.university,
    this.year = 18,
    this.countDayCheckin,
    this.countDayTracking,
    this.tokenDevice,
    this.image,
    this.setPassword = true,
  });

  UserRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    changePass = json['changePass'];
    active = json['active'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    dob = json['dob'];
    birthPlace = json['birthPlace'];
    email = json['email'];
    hasPhoto = json['hasPhoto'];
    if (json['roles'] != null) {
      roles = <Role>[];
      json['roles'].forEach((v) {
        roles!.add(Role.fromJson(v));
      });
    }
    gender = json['gender'];
    university = json['university'];
    year = json['year'];
    countDayCheckin = json['countDayCheckin'];
    countDayTracking = json['countDayTracking'];
    tokenDevice = json['tokenDevice'];
    image = json['image'];
    setPassword = json['setPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['username'] = username;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['changePass'] = changePass;
    data['active'] = active;
    data['lastName'] = lastName;
    data['firstName'] = firstName;
    data['dob'] = dob;
    data['birthPlace'] = birthPlace;
    data['email'] = email;
    data['hasPhoto'] = hasPhoto;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['gender'] = gender;
    data['university'] = university;
    data['year'] = year;
    data['countDayCheckin'] = countDayCheckin;
    data['countDayTracking'] = countDayTracking;
    data['tokenDevice'] = tokenDevice;
    data['image'] = image;
    data['setPassword'] = setPassword;
    return data;
  }

  UserRes copyWith({
    int? id,
    String? displayName,
    String? username,
    String? password,
    String? confirmPassword,
    bool? changePass,
    bool? active,
    String? lastName,
    String? firstName,
    String? dob,
    String? birthPlace,
    String? email,
    bool? hasPhoto,
    List<Role>? roles,
    String? gender,
    String? university,
    int? year,
    int? countDayCheckin,
    int? countDayTracking,
    String? tokenDevice,
    String? image,
    bool? setPassword,
  }) {
    return UserRes(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      changePass: changePass ?? this.changePass,
      active: active ?? this.active,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      birthPlace: birthPlace ?? this.birthPlace,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      gender: gender ?? this.gender,
      university: university ?? this.university,
      year: year ?? this.year,
      countDayCheckin: countDayCheckin ?? this.countDayCheckin,
      countDayTracking: countDayTracking ?? this.countDayTracking,
      tokenDevice: tokenDevice ?? this.tokenDevice,
      image: image ?? this.image,
      setPassword: setPassword ?? this.setPassword,
    );
  }
}
