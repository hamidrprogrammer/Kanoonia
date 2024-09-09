import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/body/gift/GetPopupMessagesResponse.dart';

class SetPopupSeenUseCase extends BaseUseCase {

  void runJob({MyFlow<AppState>? flow, required int popId}) async {
    try {
      flow?.emit(AppState.loading);
      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id))
              .toJson();
      userId["popupId"] = popId.toString();
      Uri uri =
          UriCreator.createUri(path: UserApiRoutes.setPopupSeen, body: userId);
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      Logger.d(response.body);
      if (response.isSuccessful) {
        Logger.d(response.body);
        var setLogResponse = getPopupMessagesResponseFromJson(response.body);
        if (setLogResponse.status == 1 && setLogResponse.data?.state == 1) {
          session.insertData({UserSessionConst.hasMessage: ""});
          flow?.emit(AppState.success(setLogResponse));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: setLogResponse.data?.message ?? '',
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

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {}
}
