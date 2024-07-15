class TokenRequest {
  String? username;
  String? password;
  String? clientId;
  String? grantType;
  String? clientSecret;

  TokenRequest({
    this.username,
    this.password,
    this.clientId,
    this.grantType,
    this.clientSecret,
  });

  TokenRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    clientId = json['client_id'];
    grantType = json['grant_type'];
    clientSecret = json['client_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['client_id'] = clientId;
    data['grant_type'] = grantType;
    data['client_secret'] = clientSecret;
    return data;
  }
}
