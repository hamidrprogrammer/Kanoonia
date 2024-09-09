import 'package:kanooniha/common/network/workBook/WorkBookApiRoutes.dart';
import 'package:kanooniha/data/serializer/workBook/newListExam/newListExamSerializer.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class DateValueListUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: WorkBookApiRoutes.dateValueList);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      var exams = dateValueListSerializerFromJson(response);
      exams.removeWhere((element) =>
          element.isPastTest == false && element.isPresent == false);
      flow?.emitData(exams);
    }
  }
}
