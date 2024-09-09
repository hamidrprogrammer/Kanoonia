import 'package:kanooniha/common/network/app/AppApiRoutes.dart';
import 'package:kanooniha/data/serializer/app/MenuItemSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class AppMenuUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: AppApiRoutes.menu);
    var response = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
    if (response != null) {
      flow?.emitData(menuItemsSerializerFromJson(response));
    }
  }
}
