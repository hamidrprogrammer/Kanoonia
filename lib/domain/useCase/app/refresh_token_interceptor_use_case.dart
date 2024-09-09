import 'package:core/network/interceptor/AuthorizationInterceptor.dart';
import 'package:core/network/interceptor/RefreshTokenInterceptor.dart';
import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/domain/useCase/user/login/refreshTokenUseCase.dart';

class RefreshTokenInterceptorUseCase extends BaseUseCase {
  @override
  Future<void> invoke({MyFlow<AppState>? flow, Object? data}) async {
    if (GetIt.I.isRegistered<RefreshTokenInterceptor>() && GetIt.I.isRegistered<LocalSessionImpl>() && GetIt.I.isRegistered<AuthorizationInterceptor>()) {
      var token =
          await GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.token);
      if (token != '') {
        GetIt.I.get<RefreshTokenInterceptor>().func =
            RefreshTokenUseCase().refreshToken;
        GetIt.I.get<AuthorizationInterceptor>().setToken(token);
      }else{
        flow?.throwMessage('token should be not empty');
      }
    } else {
      flow?.throwEmptyDataMessage('the interceptors must be initialized should registered');
    }
  }
}
