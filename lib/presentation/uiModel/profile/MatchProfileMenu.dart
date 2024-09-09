import 'ProfileMenuModel.dart';

class MatchProfileMenu extends ProfileMenuModel {
  @override
  IconData icon() {
    return CupertinoIcons.info_circle;
  }

  @override
  String name() {
    return 'مسابقه';
  }

  @override
  String path() {
    return AppRoutes.matchPage;
  }
}
