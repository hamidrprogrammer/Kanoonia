import 'package:flutter/cupertino.dart';
import 'package:kanooniha/presentation/ui/exam/ExamPageUI.dart';

import 'HomeNavigationModel.dart';

class ExamNavigationModel extends HomeNavigationModel {
  @override
  IconData icon() {
    return CupertinoIcons.pencil_circle;
  }

  @override
  String name = 'آزمون';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.exam;
  }

  @override
  String badge() {
    return '';
  }

  @override
  Widget page() => const ExamPageUI();

  @override
  String serverSideName() => 'Test';
}
