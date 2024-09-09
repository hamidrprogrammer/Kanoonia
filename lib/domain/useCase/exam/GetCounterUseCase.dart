import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/data/body/login/LoginBody.dart';
import 'package:kanooniha/data/serializer/RegisterResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';
import 'package:core/storage/shared/LocalSessionImpl.dart';

class GetCounterUseCase extends BaseUseCase {
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      var counter = await session.getData(UserSessionConst.counter);
      if (counter.isEmpty) {
        LoginBody loginBody = LoginBody(
          mobile: await session.getData(UserSessionConst.mobile),
          password: await session.getData(UserSessionConst.nationalCode),
        );

        Uri uri = UriCreator.createUri(
            path: UserApiRoutes.login, body: loginBody.toJson());
        var response = await apiServiceImpl.post(uri);

        if (response.isSuccessful) {
          /**
           * [RegisterResponse.dart] is same with login response
           */
          Logger.d(response.body);
          var registerResponse = registerResponseFromJson(response.body);
          if (registerResponse.status == 1 &&
              (registerResponse.data?.state == 1 ||
                  registerResponse.data?.state == 5)) {
            flow?.emit(AppState.success(
                registerResponse.data?.user?.counter?.toString() ?? ''));
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
      } else {
        flow?.emit(AppState.success(counter));
      }
    } catch (e) {
      Logger.e(e);
      flow?.throwCatch();
    }
  }
}
