import 'package:kanooniha/common/network/account/AccountApiRoutes.dart';
import 'package:kanooniha/data/serializer/user/UserInfoSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class GetUserInfoUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: AccountApiRoutes.userInfo);
    var response = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
    if (response != null) {
      flow?.emitData(userInfoSerializerFromJson(response));
    }
  }
}
