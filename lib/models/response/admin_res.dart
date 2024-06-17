class AdminRes {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  Admin? admin;
  String? jti;

  AdminRes(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.scope,
      this.admin,
      this.jti});

  AdminRes.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    admin = json['user'] != null ? Admin.fromJson(json['user']) : null;
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    if (admin != null) {
      data['user'] = admin!.toJson();
    }
    data['jti'] = jti;
    return data;
  }
}

class Admin {
  int? createDate;
  int? createdBy;
  int? modifyDate;
  Null? modifiedBy;
  int? id;
  String? gender;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? active;
  bool? credentialsNonExpired;
  String? email;
  String? phone;
  bool? justCreated;
  int? lastLoginFailures;
  String? lastLoginTime;
  int? totalLoginFailures;
  int? orgId;
  List<String>? roles;
  List<String>? authorities;

  Admin(
      {this.createDate,
      this.createdBy,
      this.modifyDate,
      this.modifiedBy,
      this.id,
      this.gender,
      this.username,
      this.accountNonExpired,
      this.accountNonLocked,
      this.active,
      this.credentialsNonExpired,
      this.email,
      this.phone,
      this.justCreated,
      this.lastLoginFailures,
      this.lastLoginTime,
      this.totalLoginFailures,
      this.orgId,
      this.roles,
      this.authorities});

  Admin.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    createdBy = json['createdBy'];
    modifyDate = json['modifyDate'];
    modifiedBy = json['modifiedBy'];
    id = json['id'];
    gender = json['gender'];
    username = json['username'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    active = json['active'];
    credentialsNonExpired = json['credentialsNonExpired'];
    email = json['email'];
    phone = json['phone'];
    justCreated = json['justCreated'];
    lastLoginFailures = json['lastLoginFailures'];
    lastLoginTime = json['lastLoginTime'];
    totalLoginFailures = json['totalLoginFailures'];
    orgId = json['orgId'];
    roles = json['roles'].cast<String>();
    authorities = json['authorities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['createdBy'] = createdBy;
    data['modifyDate'] = modifyDate;
    data['modifiedBy'] = modifiedBy;
    data['id'] = id;
    data['gender'] = gender;
    data['username'] = username;
    data['accountNonExpired'] = accountNonExpired;
    data['accountNonLocked'] = accountNonLocked;
    data['active'] = active;
    data['credentialsNonExpired'] = credentialsNonExpired;
    data['email'] = email;
    data['phone'] = phone;
    data['justCreated'] = justCreated;
    data['lastLoginFailures'] = lastLoginFailures;
    data['lastLoginTime'] = lastLoginTime;
    data['totalLoginFailures'] = totalLoginFailures;
    data['orgId'] = orgId;
    data['roles'] = roles;
    data['authorities'] = authorities;
    return data;
  }
}
