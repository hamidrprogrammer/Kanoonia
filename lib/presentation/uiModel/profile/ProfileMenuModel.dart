import 'package:flutter/cupertino.dart';

export 'package:flutter/cupertino.dart';
export 'package:kanooniha/common/appCommons/appRoutes.dart';

export 'ProfileMenuModel.dart';

abstract class ProfileMenuModel {
  String name();

  String get getName => name();

  String path();

  String get getPath => path();

  IconData icon();

  IconData get getIcon => icon();
}
