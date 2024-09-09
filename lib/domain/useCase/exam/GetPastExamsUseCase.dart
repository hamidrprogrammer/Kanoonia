import 'dart:convert';

import 'package:core/storage/shared/LocalSessionImpl.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/ExamApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/exam/PastTestResponse.dart';

class GetPastExamsUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);

      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id));
      Uri uri = UriCreator.createUri(path: ExamApiRoutes.getUserPastTestDates);
      Logger.d(userId.toJson());
      var response = await apiServiceImpl.post(uri, data: json.encode(userId));
      Logger.d(response.body);
      if (response.isSuccessful) {
        var examDetail = pastTestResponseFromJson(response.body);
        if (examDetail.status == 1 && examDetail.data?.state == 1) {
          flow?.emit(AppState.success(examDetail));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: examDetail.data?.message ?? '',
              ),
            ),
          );
        }
      } else {
        flow?.emit(
          AppState.error(
            ErrorHandlerImpl().makeError(response),
          ),
        );
      }
    } catch (e) {
      Logger.e(e);
      flow?.emit(
        AppState.error(
          const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_Connection,
          ),
        ),
      );
    }
  }
}
