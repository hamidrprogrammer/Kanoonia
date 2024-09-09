import 'package:kanooniha/common/network/account/AccountApiRoutes.dart';
import 'package:kanooniha/data/body/user/UserInfoCallResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class FireBaseTokenUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is String);
    try {
      flow?.emit(AppState.loading);

      Uri uri = createUri(path: AccountApiRoutes.userFireBaseToken);

      var res = await tryCatch(
          future: apiServiceImpl.post(uri, data: {'token': data}), flow: flow);
      if (res != null) {
        flow?.emitData(true);
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
