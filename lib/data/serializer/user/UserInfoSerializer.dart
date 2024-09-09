import 'dart:convert';

UserInfoSerializer userInfoSerializerFromJson(String str) =>
    UserInfoSerializer.fromJson(json.decode(str));

String userInfoSerializerToJson(UserInfoSerializer data) =>
    json.encode(data.toJson());

class UserInfoSerializer {
  UserInfoSerializer({
    this.userGuid,
    this.fullName,
    this.currentYear,
    this.groupCode,
    this.groupName,
  });

  UserInfoSerializer.fromJson(dynamic json) {
    userGuid = json['userGuid'];
    fullName = json['fullName'];
    groupCode = json['groupCode'];
    currentYear = json['currentYear'];
    groupName = json['groupName'];
  }

  String? userGuid;
  String? fullName;
  String? currentYear;
  num? groupCode;
  String? groupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userGuid'] = userGuid;
    map['fullName'] = fullName;
    map['groupCode'] = groupCode;
    map['groupName'] = groupName;
    return map;
  }
}
