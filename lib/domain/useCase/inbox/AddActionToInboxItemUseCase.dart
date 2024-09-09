
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/InboxApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/BaseResponse.dart';

class AddActionToInboxItemUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  void addActionToInboxItem(int itemId) async {
    Logger.d('calling setSeen');
    try {
      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id))
              .toJson();
      userId['itemId'] = itemId.toString();

      Uri uri = UriCreator.createUri(
          path: InboxApiRoutes.addActionToInboxItem, body: userId);
      Logger.d(userId);
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      if (response.isSuccessful) {
        var examDetail = baseResponseFromJson(response.body);
        if (examDetail.status == 1 && examDetail.data?.state == 1) {
          Logger.d('successfully sent');
        } else {
          Logger.e(ErrorModel(
            state: ErrorState.Message,
            message: examDetail.data?.message ?? '',
          ).message);
        }
      } else {
        Logger.e(ErrorHandlerImpl().makeError(response).message);
      }
    } catch (e) {
      Logger.e(e);
    }
  }

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {}
}
