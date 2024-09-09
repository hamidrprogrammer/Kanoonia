import 'package:kanooniha/presentation/uiModel/home/workbook_navigation_model.dart';

import 'ExamNavigationModel.dart';
import 'HomeNavigationModel.dart';
import 'MessagesNavigationModel.dart';
import 'ProfileNavigationModel.dart';

class HomeNavigationObject {
  static List<HomeNavigationModel> get homeMenu => [
        ExamNavigationModel(),
        // EasyQuestionNavigationModel(),
        // WorkBookInNavigationNavigationModel(),
        WorkBookNavigationModel(),
      ];

  static List<HomeNavigationModel> get appbarMenu => [
        ProfileNavigationModel(),
        MessagesNavigationModel(),
      ];
}
