import 'ProfileMenuModel.dart';

class PastExamProfileMenu extends ProfileMenuModel {
  @override
  IconData icon() {
    return CupertinoIcons.list_number_rtl;
  }

  @override
  String name() {
    return 'آزمون های گذشته';
  }

  @override
  String path() {
    return AppRoutes.pastExamsPage;
  }
}
