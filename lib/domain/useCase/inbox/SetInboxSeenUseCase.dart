import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/InboxApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/BaseResponse.dart';

class SetInboxSeenUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    Logger.d('calling setSeen');
    try {
      flow?.emit(AppState.loading);

      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id));
      Uri uri = UriCreator.createUri(
          path: InboxApiRoutes.setInboxSeen, body: userId.toJson());
      Logger.d(userId.toJson());
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      if (response.isSuccessful) {
        var examDetail = baseResponseFromJson(response.body);
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
