import 'package:traking_app/models/body/role_body.dart';

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
  List<RoleBody>? roles;
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
    this.changePass,
    this.active,
    this.lastName,
    this.firstName,
    this.dob,
    this.birthPlace,
    this.email,
    this.hasPhoto,
    this.roles,
    this.gender,
    this.university,
    this.year,
    this.countDayCheckin,
    this.countDayTracking,
    this.tokenDevice,
    this.image,
    this.setPassword,
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
      roles = <RoleBody>[];
      json['roles'].forEach((v) {
        roles!.add(new RoleBody.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['username'] = this.username;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['changePass'] = this.changePass;
    data['active'] = this.active;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['dob'] = this.dob;
    data['birthPlace'] = this.birthPlace;
    data['email'] = this.email;
    data['hasPhoto'] = this.hasPhoto;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['gender'] = this.gender;
    data['university'] = this.university;
    data['year'] = this.year;
    data['countDayCheckin'] = this.countDayCheckin;
    data['countDayTracking'] = this.countDayTracking;
    data['tokenDevice'] = this.tokenDevice;
    data['image'] = this.image;
    data['setPassword'] = this.setPassword;
    return data;
  }
}
