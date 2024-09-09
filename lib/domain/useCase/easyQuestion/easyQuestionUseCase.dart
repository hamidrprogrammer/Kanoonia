import 'dart:convert';

import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/easyQuestion/EasyQuestionItem.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/domain/useCase/workBook/newWorkBook/in_app_workBook_useCase.dart';
import 'package:kanooniha/presentation/uiModel/easyQuestion/EasyQuestionModel.dart';

class EasyQuestionUseCase extends BaseUseCase {
  void getWorkBookByBody({
    required MyFlow<AppState> flow,
  }) async {
    try {
      NewWorkBookBody body = NewWorkBookBody(kind: 'WorkbookEasy');
      InAppWorkBookUseCase().invoke(
        flow: MyFlow((appState) {
          if (appState.isSuccess) {

            var data = easyQuestionItemFromJson(appState.getData.toString().replaceAll(r'\', ''));
            List<int> ids = [];
            List<String> names = [];
            for (var question in data) {
              if (!ids.contains(question.courseId)) {
                ids.add(question.courseId);
              }
              if (!names.contains(question.courseName)) {
                names.add(question.courseName);
              }
            }
            EasyQuestionUiModel items =
            EasyQuestionUiModel(data: [], courses: names, ids: ids);
            for (var courseId in ids) {
              var questions =
              data.where((element) => element.courseId == courseId);
              for (var item in questions) {
                int index = items.data.indexWhere((e) =>
                e.testDate == item.testDate && e.id == item.courseId);
                if (index != -1) {
                  items.data[index] =
                      items.data[index].plus(item.createEasyQuestionModel());
                } else {
                  items.data.add(item.createEasyQuestionModel());
                }
              }
            }

            flow.emit(AppState.success(items));
          } else {
            flow.emit(appState);
          }
        }),
        data: body,
      );
    } catch (e) {
      flow.emit(
        AppState.error(
          const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_Connection,
          ),
        ),
      );
    }
  }

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {}
}
