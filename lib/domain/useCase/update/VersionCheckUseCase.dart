import 'package:kanooniha/common/network/app/AppApiRoutes.dart';
import 'package:kanooniha/core/flow/MyFlow.dart';
import 'package:kanooniha/data/serializer/update/VersionCheckSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/presentation/states/app_state.dart';

class VersionCheckUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: AppApiRoutes.versionCheck);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      VersionCheckSerializer result = versionCheckSerializerFromJson(response);
      if (result.isForceUpdate == true) {
        flow?.emitData(result);
      } else {
        flow?.throwMessage(result.message ?? '');
      }
    }
  }
}
