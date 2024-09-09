import 'package:kanooniha/data/body/login/verification/VerificationBody.dart';
import 'package:kanooniha/data/serializer/RegisterResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';
import '../../formState/login/VerifictionFormState.dart';

class VerificationUseCase extends BaseUseCase {
  VerificationUseCase.initFormState({required this.verificationFormState});

  VerificationFormState verificationFormState;

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      VerificationBody verificationBody =
          VerificationBody(mobile: verificationFormState.mobile);

      Uri uri = UriCreator.createUri(
          path: UserApiRoutes.validateUser, body: verificationBody.toJson());
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        /**
         * [RegisterResponse.dart] is same with validate response
         */
        var registerResponse = registerResponseFromJson(response.body);
        Logger.d(response.body);
        if (registerResponse.status == 1 &&
            (registerResponse.data?.state == 1 ||
                registerResponse.data?.state == 3)) {
          flow?.emit(AppState.success(registerResponse.data?.user));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: registerResponse.data?.message ?? '',
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
