import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/userApiRoutes.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../core/app/AndroidPackageInfoUseCase.dart';
import '../../../data/body/update/UpdateBody.dart';
import '../../../data/serializer/update/UpdateResponse.dart';

class CheckForUpdateUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    try {
      flow?.emit(AppState.loading);
      var userId = await session.getData(UserSessionConst.id);
      var appInfo = await AndroidPackageInfo.invoke();
      var updateBody = UpdateBody(AppId: '21', lastVersion: '59').toJson();
      updateBody['isAndroid'] = kIsWeb ? 'false' : 'true';
      if (userId.isNotEmpty) {
        updateBody['userId'] = userId.toString();
      }
      Uri uri = UriCreator.createUri(
          path: UserApiRoutes.getVersion, body: updateBody);
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        var updateData = updateResponseFromJson(response.body);
        if (updateData.data?.isForceUpdate == true) {
          flow?.emit(AppState.success(updateData));
        } else {
          flow?.emit(
            AppState.error(
              ErrorModel(
                state: ErrorState.Message,
                message: updateData.data?.message ?? '',
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
