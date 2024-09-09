import 'package:kanooniha/data/body/login/forgetPassword/ForgetPasswordBody.dart';
import 'package:kanooniha/data/serializer/ForgetPasswordResponse.dart';
import 'package:kanooniha/domain/formState/login/ForgetPasswordFormState.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';

class ForgetPasswordUseCase extends BaseUseCase {
  ForgetPasswordUseCase.initFormState({required this.forgetPasswordFormState});

  ForgetPasswordFormState forgetPasswordFormState;

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      ForgetPasswordBody forgetPasswordBody = ForgetPasswordBody(
        mobile: forgetPasswordFormState.mobile,
      );

      Uri uri = UriCreator.createUri(
          path: UserApiRoutes.forgetPassword,
          body: forgetPasswordBody.toJson());
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        Logger.d(response.body);
        var forgetPasswordResponse =
            forgetPasswordResponseFromJson(response.body);
        if (forgetPasswordResponse.status == 1 &&
            forgetPasswordResponse.data?.state == 1) {
          flow?.emit(AppState.success(forgetPasswordResponse));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: forgetPasswordResponse.data?.message ?? '',
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
