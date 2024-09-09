import 'package:flutter/cupertino.dart';
import 'package:kanooniha/presentation/ui/workbook/newWorkBookUi/new_workbook_ui.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';

class WorkBookNavigationModel extends HomeNavigationModel {
  @override
  String badge() => '';

  @override
  IconData icon() => CupertinoIcons.arrow_down_doc;

  @override
  String name = 'کارنامه';

  @override
  Widget page() => const NewWorkBookUi();

  @override
  HomeNavigationEnum value() => HomeNavigationEnum.workBook;

  @override
  String serverSideName() => 'WorkBook';
}
