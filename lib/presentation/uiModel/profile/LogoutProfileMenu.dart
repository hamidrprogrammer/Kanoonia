import 'package:flutter/material.dart';

import 'ProfileMenuModel.dart';

class LogoutProfileMenu extends ProfileMenuModel{
  @override
  IconData icon() {
    return Icons.close;
  }

  @override
  String name() {
    return 'خروج';
  }

  @override
  String path() {
    return AppRoutes.login;
  }

}