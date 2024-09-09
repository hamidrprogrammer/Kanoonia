import 'dart:convert';

import 'package:kanooniha/common/network/account/AccountApiRoutes.dart';
import 'package:kanooniha/data/body/login/newLogin/new_login_body.dart';
import 'package:kanooniha/data/serializer/user/LoginSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class NewLoginUseCase extends BaseUseCase {
  @override
  void invoke({
    MyFlow<AppState>? flow,
    Object? data,
  }) async {
    assert(data != null && data is NewLoginBody);
    var uri = createUri(path: AccountApiRoutes.userLogin);
    var result = await tryCatch(
        future: apiServiceImpl.post(uri,data: jsonEncode(data)), flow: flow);
    if (result != null) {
      LoginSerializer loginSerializer = loginSerializerFromJson(result);
      if (loginSerializer.success == true) {
        flow?.emitData(loginSerializer);
      } else {
        flow?.throwMessage(loginSerializer.message ?? '');
      }
    }
  }
}
