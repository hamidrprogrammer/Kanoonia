import 'package:kanooniha/presentation/uiModel/profile/ProfileMenuModel.dart';

import '../../../common/imports/appImports.dart';

class WorkBookProfileModel extends ProfileMenuModel {
  @override
  IconData icon() {
    return Icons.line_weight_sharp;
  }

  @override
  String name() {
    return 'اخبار';
  }

  @override
  String path() {
    return AppRoutes.news;
  }
}
