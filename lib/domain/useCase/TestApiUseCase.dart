import 'package:kanooniha/data/serializer/TestResponse.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class TestApiUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    flow?.emit(AppState.loading);
    var url =
        UriCreator.createUri(path: '/books/v1/volumes', body: {'q': '{http}'});
    var response = await apiServiceImpl.get(url);
    if (response.statusCode == 200) {
      var json = testResponseFromJson(response.body);
      flow?.emit(AppState.success(json));
    } else {
      // flow.emit(AppState.error);
    }
  }
}
