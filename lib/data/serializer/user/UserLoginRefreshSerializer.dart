import 'dart:convert';
UserLoginRefreshSerializer userLoginRefreshSerializerFromJson(String str) => UserLoginRefreshSerializer.fromJson(json.decode(str));
String userLoginRefreshSerializerToJson(UserLoginRefreshSerializer data) => json.encode(data.toJson());
class UserLoginRefreshSerializer {
  UserLoginRefreshSerializer({
      this.token, 
      this.refreshToken,});

  UserLoginRefreshSerializer.fromJson(dynamic json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  String? token;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    return map;
  }

}