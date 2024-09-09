import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/MessengerApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/messenger/FetchAllMessagesListResponse.dart';


class FetchAllMessagesListUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();
  final String path;

  FetchAllMessagesListUseCase.initForAllMessages(
      {this.path = MessengerApiRoutes.fetchAllMessagesList});

  FetchAllMessagesListUseCase.initForAllUnreadMessages(
      {this.path = MessengerApiRoutes.fetchUnreadedMessagesList});

  FetchAllMessagesListUseCase.initForHomePage(
      {this.path = MessengerApiRoutes.fetchUnreadedMessagesListForHomePage});

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      Logger.d('sending request for messages');
      flow?.emit(AppState.loading);

      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id));
      Uri uri = UriCreator.createUri(path: path, body: userId.toJson());
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      if (response.isSuccessful) {
        var examDetail = fetchAllMessagesListResponseFromJson(response.body);
        if (examDetail.status == 1) {
          flow?.emit(AppState.success(examDetail));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: examDetail.message ?? '',
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
