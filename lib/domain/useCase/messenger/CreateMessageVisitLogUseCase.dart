import 'dart:convert';

import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/MessengerApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/messenger/CreateMessageVisitLogBody.dart';
import '../../../data/serializer/BaseResponse.dart';


class CreateMessageVisitLogUseCase extends BaseUseCase {

  void createLog({
    required MyFlow<AppState> flow,
    required VisitedMessagesBody messagesBody,
  }) async {
    try {
      flow.emit(AppState.loading);

      var body = CreateMessageVisitLogBody(
        userId: await session.getData(UserSessionConst.id),
        VisitedMessages: [messagesBody],
      );
      Uri uri =
          UriCreator.createUri(path: MessengerApiRoutes.createMessageVisitLog);
      var response = await apiServiceImpl.post(uri, data: json.encode(body));
      Logger.d(response.body);
      if (response.isSuccessful) {
        var examDetail = baseResponseFromJson(response.body);
        if (examDetail.status == 1) {
          flow.emit(AppState.success(examDetail));
        } else {
          flow.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: examDetail.message ?? '',
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
  void invoke({MyFlow<AppState>? flow, Object? data}) async {}
}
