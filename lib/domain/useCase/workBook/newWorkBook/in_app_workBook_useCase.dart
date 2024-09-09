import 'package:kanooniha/common/network/workBook/WorkBookApiRoutes.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/workBook/inAppWorkBook/InAppWorkBookSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class InAppWorkBookUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is NewWorkBookBody);
    var uri = createUri(
        path: WorkBookApiRoutes.workBook,
        body: (data as NewWorkBookBody).toJson());
    var response = await tryCatch(future: apiServiceImpl.post(uri), flow: flow);
    if (response != null) {
      var serializer = inAppWorkBookSerializerFromJson(response);
      flow?.emitData(serializer.workBook);
    }
  }
}
