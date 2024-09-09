import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/WorkBookApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/body/workBook/GetWorkBookBody.dart';
import '../../../data/serializer/workBook/GetWorkBookResponse.dart';


class GetWorkBookUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  void getWorkBook({
    required int testDate,
    required int kindId,
    required MyFlow<AppState> flow,
  }) async {
    try {
      flow.emit(AppState.loading);
      var workBookBody = GetWorkBookBody(
        userId: await session.getData(UserSessionConst.id),
        testDate: testDate.toString(),
        kindId: kindId.toString(),
      );

      Uri uri = UriCreator.createUri(
          path: WorkBookApiRoutes.getWorkBook, body: workBookBody.toJson());
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        var data = getWorkBookResponseFromJson(response.body);
        Logger.d(response.body);
        if (data.status == 1 && data.data?.state == 1) {
          flow.emit(AppState.success(data));
        } else {
          flow.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: data.data?.message ?? '',
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
