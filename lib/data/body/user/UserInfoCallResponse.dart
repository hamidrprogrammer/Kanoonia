import 'dart:convert';
import 'dart:math';

import 'package:core/call/user.dart';

UserInfoCallResponse userInfoCallResponseFromJson(String str) =>
    UserInfoCallResponse.fromJson(json.decode(str));

String userInfoCallResponseToJson(UserInfoCallResponse data) =>
    json.encode(data.toJson());

class UserInfoCallResponse {
  UserInfoCallResponse({
    this.userGuid,
    this.fullName,
    this.groupCode,
    this.groupName,
    this.avatar,
    this.currentYear,
    this.userIdCall,
    this.userOfficeIdCall,
    this.userAllowCall,
  });

  UserInfoCallResponse.fromJson(dynamic json) {
    userGuid = json['userGuid'];
    fullName = json['fullName'];
    groupCode = json['groupCode'];
    groupName = json['groupName'];
    avatar = json['avatar'];
    currentYear = json['currentYear'];
    userIdCall = json['userIdCall'];
    userOfficeIdCall = json['userOfficeIdCall'];
    userAllowCall = json['userAllowCall'];
  }

  String? userGuid;
  String? fullName;
  num? groupCode;
  String? groupName;
  String? avatar;
  num? currentYear;
  String? userIdCall;
  String? userOfficeIdCall;
  bool? userAllowCall;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userGuid'] = userGuid;
    map['fullName'] = fullName;
    map['groupCode'] = groupCode;
    map['groupName'] = groupName;
    map['avatar'] = avatar;
    map['currentYear'] = currentYear;
    map['userIdCall'] = userIdCall;
    map['userOfficeIdCall'] = userOfficeIdCall;
    map['userAllowCall'] = userAllowCall;
    return map;
  }

  User createUser({String? token}) {
    return User(
      userName: fullName ?? '${Random().nextInt(100000)}',
      connectionId: '',
      userId: userIdCall ?? '',
      officeId: userOfficeIdCall ?? '',
      isOffice: false,
      inCall: false,
      firebaseUserToken: token
    );
  }
}
