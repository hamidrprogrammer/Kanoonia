import 'package:flutter/cupertino.dart';
import 'package:kanooniha/presentation/ui/easeQuestion/EasyQuestionUi.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';

class EasyQuestionNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.quote_bubble;
  }

  @override
  String name = 'سوالات ساده';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.easyQuestion;
  }

  @override
  Widget page() => const EasyQuestionsUi();

  @override
  String serverSideName() => '';
}
