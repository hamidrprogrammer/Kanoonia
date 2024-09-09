import 'package:kanooniha/common/network/support/SupportApiRoutes.dart';
import 'package:kanooniha/data/serializer/support/support_kind_item.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class NewSupportKindUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: SupportApiRoutes.supportRequestKinds);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      flow?.emitData(supportKindItemFromJson(response));
    }
  }
}
