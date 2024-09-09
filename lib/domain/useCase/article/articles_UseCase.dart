import 'package:kanooniha/common/network/app/AppApiRoutes.dart';
import 'package:kanooniha/data/serializer/article/ArticleItemSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class ArticlesUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: AppApiRoutes.articleNew);
    var response = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
    if (response != null) {
      flow?.emitData(articleItemsSerializerFromJson(response));
    }
  }
}
