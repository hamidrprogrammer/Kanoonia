import 'package:flutter/cupertino.dart';
import 'package:kanooniha/data/serializer/user/UserInfoSerializer.dart';

class UserModel {
  final String fullName, paye, currentYear;
  final IconData iconData;

  UserModel({
    required this.currentYear,
    required this.fullName,
    required this.paye,
    required this.iconData,
  });
}

extension UserModelExtension on UserInfoSerializer{
  UserModel createUserModel() {
    return UserModel(fullName: fullName ?? '', paye: groupName ?? '', iconData: CupertinoIcons.person,currentYear: currentYear ?? '');
  }
}
