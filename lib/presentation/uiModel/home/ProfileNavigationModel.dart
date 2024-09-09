import 'package:flutter/cupertino.dart';
import 'package:kanooniha/presentation/ui/profile/ProfilePageUI.dart';

import 'HomeNavigationModel.dart';

class ProfileNavigationModel extends HomeNavigationModel {
  @override
  IconData icon() {
    return CupertinoIcons.person_fill;
  }

  @override
  String name = 'پروفایل';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.profile;
  }

  @override
  String badge() {
    return '';
  }

  @override
  Widget page() => const ProfilePageUI();

  @override
  String serverSideName() => 'Profile';

}
