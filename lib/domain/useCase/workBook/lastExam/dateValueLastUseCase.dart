import 'package:kanooniha/common/network/workBook/WorkBookApiRoutes.dart';
import 'package:kanooniha/data/serializer/workBook/newLastExam/DateValueLastSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class DateValueLastUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: WorkBookApiRoutes.dateValueLast);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      flow?.emitData(dateValueLastSerializerFromJson(response));
    }
  }
}
