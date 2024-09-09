import 'package:kanooniha/common/network/account/AccountApiRoutes.dart';
import 'package:kanooniha/data/body/user/UserInfoCallResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class GetUserCallInfoUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);

      Uri uri =
          createUri(path: AccountApiRoutes.userInfoCall);

      var res = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
      if (res != null) {
        flow?.emitData(userInfoCallResponseFromJson(res));
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
