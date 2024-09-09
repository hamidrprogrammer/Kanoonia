import 'dart:convert';

import 'package:kanooniha/common/network/WorkBookApiRoutes.dart';
import 'package:kanooniha/data/body/workBook/WorkBookInNavigationBody.dart';
import 'package:kanooniha/data/serializer/workBook/WorkBookInNavigationResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class WorkBookByWorkBookBodyUseCase extends BaseUseCase {
  void getWorkBookByBody({
    required WorkBookInNavigationBody body,
    required MyFlow<AppState> flow,
  }) async {
    try {
      // var json = await rootBundle.loadString('assets/workBook.json');
      // var data = workBookInNavigationResponseFromJson(json);
      // data.date = body.testDate;
      // flow.emit(AppState.success(data));
      // return;

      var uri = UriCreator.createUri(
          path: WorkBookApiRoutes.getWorkBookDetail, body: body.toJson());
      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var status = jsonDecode(response.body)["Status"];
        if (status == 1) {
          var str = jsonDecode(response.body)["Data"];
          var data = workBookInNavigationResponseFromJson(str);
          data.date = body.testDate;
          flow.emit(AppState.success(data));
        } else {
          var msg = jsonDecode(response.body)["Data"];
          flow.emit(AppState.error(
              ErrorModel(state: ErrorState.Message, message: msg)));
        }
      } else {
        flow.emit(
          AppState.error(
            const ErrorModel(
              state: ErrorState.Message,
              message: ErrorMessages.ErrorMessage_Connection,
            ),
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
