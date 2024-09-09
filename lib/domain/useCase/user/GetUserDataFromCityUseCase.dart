import 'dart:convert';

import 'package:kanooniha/common/network/userApiRoutes.dart';
import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/data/body/user/UserDataBody.dart';
import 'package:kanooniha/data/serializer/user/UserDataResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class GetUserDataFromUseCase extends BaseUseCase {

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);

      Uri uri = UriCreator.createUriWithUrl(
          url: "city.kanoon.ir", path: UserApiRoutes.getUserData);
      var body = UserDataBody(
          userId: await session.getData(UserSessionConst.id),
          privateKey: "app2023");
      var response = await apiServiceImpl.post(uri, data: jsonEncode(body));
      if (response.isSuccessful) {
        Logger.d(response.body);
        var registerResponse = userDataResponseFromJson(response.body);
        if (registerResponse.success == true) {
          flow?.emit(AppState.success(registerResponse));
        } else {
          flow?.emit(
            AppState.error(
              const ErrorModel(
                state: ErrorState.Message,
                message: 'خطا در دریافت اطلاعات',
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
