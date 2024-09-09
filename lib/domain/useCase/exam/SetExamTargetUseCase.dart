import 'dart:convert';

import 'package:kanooniha/data/body/exam/ExamAddTargetBody.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/ExamApiRoutes.dart';
import '../../../data/serializer/exam/AddTargetResponse.dart';

class SetExamTargetUseCase extends BaseUseCase {
  void setExamTarget({
    required ExamAddTargetBody body,
    required MyFlow<AppState> flow,
  }) async {
    try {
      flow.emit(AppState.loading);
      Logger.d(body.toJson());
      Uri uri = UriCreator.createUri(
          path: ExamApiRoutes.setTargetLevelForUserCourses);
      var response = await apiServiceImpl.post(uri, data: json.encode(body));
      Logger.d(response.body);
      if (response.isSuccessful) {
        Logger.d(response.body);
        var examDetail = addTargetResponseFromJson(response.body);
        if (examDetail.status == 1 && examDetail.data?.state == 1) {
          flow.emit(AppState.success(examDetail));
        } else {
          flow.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: examDetail.data?.message ?? '',
              ),
            ),
          );
        }
      } else {
        flow.emit(
          AppState.error(
            ErrorHandlerImpl().makeError(response),
          ),
        );
      }
    } catch (e) {
      Logger.e(e);
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
  void invoke({MyFlow<AppState>? flow, Object? data}) {}
}
