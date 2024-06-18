class User {
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

  User({
    this.active = true,
    this.birthPlace = "",
    this.changePass = true,
    this.confirmPassword,
    this.displayName = "",
    this.email = "",
    this.firstName = "",
    this.gender = "",
    this.lastName = "",
    this.password,
    this.university = "",
    this.username,
    this.year = 18,
  });

  User.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['active'] = active;
    data['birthPlace'] = birthPlace;
    data['changePass'] = changePass;
    data['confirmPassword'] = confirmPassword;
    data['displayName'] = displayName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['gender'] = gender;
    data['lastName'] = lastName;
    data['password'] = password;
    data['university'] = university;
    data['username'] = username;
    data['year'] = year;
    return data;
  }

  User copyWith({
    bool? active,
    String? birthPlace,
    bool? changePass,
    String? confirmPassword,
    String? displayName,
    String? email,
    String? firstName,
    String? gender,
    String? lastName,
    String? password,
    String? university,
    String? username,
    int? year,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      university: university ?? this.university,
      birthPlace: birthPlace ?? this.birthPlace,
      gender: gender ?? this.gender,
      active: active ?? this.active,
      changePass: changePass ?? this.changePass,
      year: year ?? this.year,
    );
  }
}
