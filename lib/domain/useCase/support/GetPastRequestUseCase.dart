import 'package:kanooniha/common/network/support/SupportApiRoutes.dart';
import 'package:kanooniha/data/serializer/support/support_item.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class GetPastRequestUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: SupportApiRoutes.supportRequestList);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      flow?.emitData(supportItemFromJson(response));
    }
  }
}
