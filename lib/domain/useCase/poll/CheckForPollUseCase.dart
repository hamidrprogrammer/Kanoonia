
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/PollApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/UserIdInputBody.dart';
import '../../../data/serializer/poll/CheckForPollResponse.dart';

class CheckForPollUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);

      var userId =
          UserIdInputBody(userId: await session.getData(UserSessionConst.id));
      Uri uri = UriCreator.createUri(
          path: PollApiRoutes.checkForPoll, body: userId.toJson());
      Logger.d(userId.toJson());
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.body);
      if (response.isSuccessful) {
        var pollData = checkForPollResponseFromJson(response.body);
        if (pollData.status == 1) {
          flow?.emit(AppState.success(pollData));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: pollData.data?.message ?? '',
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
