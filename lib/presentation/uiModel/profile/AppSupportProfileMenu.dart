import 'package:kanooniha/presentation/uiModel/profile/ProfileMenuModel.dart';

class AppSupportProfileMenu extends ProfileMenuModel{
  @override
  IconData icon() {
    return CupertinoIcons.headphones;
  }

  @override
  String name() {
    return 'پشتیبانی';
  }

  @override
  String path() {
    return AppRoutes.appSupport;
  }

}