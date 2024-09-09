import 'package:flutter/cupertino.dart';
import 'package:kanooniha/presentation/ui/workbook/WorkBookInNavigationUi.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';

class WorkBookInNavigationNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.table;
  }

  @override
  String name = 'درصد دروس';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.workBookInNavigation;
  }

  @override
  Widget page() => const WorkBookInNavigationUi();

  @override
  String serverSideName() => '';
}
