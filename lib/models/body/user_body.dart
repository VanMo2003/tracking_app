class UserBody {
  bool? active;
  String? birthPlace;
  bool? changePass;
  String? confirmPassword;
  String? displayName;
  String? email;
  String? firstName;
  String? gender;
  String? lastName;
  String? password;
  String? university;
  String? username;
  int? year;

  UserBody({
    this.active = true,
    this.birthPlace,
    this.changePass = true,
    this.confirmPassword,
    this.displayName,
    this.email,
    this.firstName,
    this.gender,
    this.lastName,
    this.password,
    this.university,
    this.username,
    this.year,
  });

  UserBody.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    birthPlace = json['birthPlace'];
    changePass = json['changePass'];
    confirmPassword = json['confirmPassword'];
    displayName = json['displayName'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    password = json['password'];
    university = json['university'];
    username = json['username'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['birthPlace'] = this.birthPlace;
    data['changePass'] = this.changePass;
    data['confirmPassword'] = this.confirmPassword;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['university'] = this.university;
    data['username'] = this.username;
    data['year'] = this.year;
    return data;
  }
}
