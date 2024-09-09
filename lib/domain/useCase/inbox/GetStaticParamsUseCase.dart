
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/InboxApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/inbox/GetStaticParamsResponse.dart';

class GetStaticParamsUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);

      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id));
      Uri uri = UriCreator.createUri(
          path: InboxApiRoutes.getStaticParams, body: userId.toJson());
      Logger.d(userId.toJson());
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      if (response.isSuccessful) {
        var getStaticParamsResponse =
            getStaticParamsResponseFromJson(response.body);
        if (getStaticParamsResponse.status == 1 &&
            getStaticParamsResponse.data?.state == 1) {
          flow?.emit(AppState.success(getStaticParamsResponse));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: getStaticParamsResponse.data?.message ?? '',
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
