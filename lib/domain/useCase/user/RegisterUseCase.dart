import 'package:kanooniha/data/serializer/RegisterResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';
import '../../../data/body/register/RegisterBody.dart';
import '../../formState/register/RegisterFormState.dart';

class RegisterUseCase extends BaseUseCase {
  RegisterUseCase.initFormState({required this.registerFormState});

  RegisterFormState registerFormState;

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      RegisterBody registerBody = RegisterBody(
        RoleId: 6.toString(),
        Mobile: registerFormState.mobile,
        NationalCode: registerFormState.nationalCode,
        Recommender: registerFormState.referredCode,
      );

      Uri uri = UriCreator.createUri(
          path: UserApiRoutes.register, body: registerBody.toJson());
      var response = await apiServiceImpl.post(uri);
      Logger.d(response.body);
      if (response.isSuccessful) {
        var registerResponse = registerResponseFromJson(response.body);
        if (registerResponse.status == 1 && registerResponse.data?.state == 1) {
          flow?.emit(AppState.success(registerResponse));
        } else {
          flow?.emit(AppState.error(ErrorModel(
              state: ErrorState.Message,
              message: registerResponse.data?.message ?? '')));
        }
      } else {
        flow?.emit(
          AppState.error(
            ErrorHandlerImpl().makeError(response),
          ),
        );
      }
    } catch (e) {
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
