import 'dart:convert';

import 'package:kanooniha/common/network/account/AccountApiRoutes.dart';
import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/data/body/user/userLoginRefreshBody.dart';
import 'package:kanooniha/data/serializer/user/UserLoginRefreshSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/domain/useCase/app/refresh_token_interceptor_use_case.dart';

class RefreshTokenUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is UserLoginRefreshBody);

    var uri = createUri(path: AccountApiRoutes.userLoginRefresh);
    var response = await tryCatch(
        future: apiServiceImpl.post(uri, data: jsonEncode(data)));
    if (response != null) {
      var result = userLoginRefreshSerializerFromJson(response);
      await session.insertData({
        UserSessionConst.token: result.token ?? '',
        UserSessionConst.refreshToken: result.refreshToken ?? ''
      });
      flow?.emitData(result);
    }
  }

  Future<String?> refreshToken() async {
    try {
      var token = await session.getData(UserSessionConst.token);
      var refreshToken = await session.getData(UserSessionConst.refreshToken);
      UserLoginRefreshBody body =
          UserLoginRefreshBody(token: token, refreshToken: refreshToken);
      var uri = createUri(path: AccountApiRoutes.userLoginRefresh);
      var response = await tryCatch(
          future: apiServiceImpl.post(uri, data: jsonEncode(body.toJson())));
      if (response != null) {
        var result = userLoginRefreshSerializerFromJson(response);
        await session.clearSession();
        await session.insertData({
          UserSessionConst.token: result.token ?? '',
          UserSessionConst.refreshToken: result.refreshToken ?? ''
        });
        RefreshTokenInterceptorUseCase().invoke();
        return result.token ?? '';
      } else {
        session.clearSession();
        return null;
      }
    } catch (e) {
      session.clearSession();
      return null;
    }
  }
}
