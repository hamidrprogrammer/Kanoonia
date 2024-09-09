import 'dart:convert';

LoginSerializer loginSerializerFromJson(String str) =>
    LoginSerializer.fromJson(json.decode(str));

String loginSerializerToJson(LoginSerializer data) =>
    json.encode(data.toJson());

class LoginSerializer {
  LoginSerializer({
    this.mobile,
    this.mobileToken,
    this.tokenJwt,
    this.tokenRefresh,
    this.loginBy,
  });

  LoginSerializer.fromJson(dynamic json) {
    message = json['message'];
    success = json['success'];
    mobile = json['mobile'];
    mobileToken = json['mobileToken'];
    tokenJwt = json['tokenJwt'];
    tokenRefresh = json['tokenRefresh'];
    loginBy = json['loginBy'];
  }

  bool? success;
  bool? mobile;
  String? message;
  String? mobileToken;
  String? tokenJwt;
  String? tokenRefresh;
  String? loginBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['mobile'] = mobile;
    map['mobileToken'] = mobileToken;
    map['tokenJwt'] = tokenJwt;
    map['tokenRefresh'] = tokenRefresh;
    map['loginBy'] = loginBy;
    return map;
  }
}
