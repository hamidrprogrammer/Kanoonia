import 'package:kanooniha/presentation/uiModel/profile/ProfileMenuModel.dart';

class AddTargetProfileModel extends ProfileMenuModel{
  @override
  IconData icon() {
    return CupertinoIcons.sidebar_right;
  }

  @override
  String name() {
    return 'هدفگذاری';
  }

  @override
  String path() {
    return AppRoutes.target;
  }

}