import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/WorkBookApiRoutes.dart';
import '../../../data/serializer/workBook/GetWorkBookKindsResponse.dart';

class GetWorkBookKindsUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      Uri uri = UriCreator.createUri(path: WorkBookApiRoutes.getWorkBookKinds);
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.statusCode);
      if (response.isSuccessful) {
        Logger.d(response.body);
        var examDetail = getWorkBookKindsResponseFromJson(response.body);
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
