import 'package:kanooniha/common/network/support/SupportApiRoutes.dart';
import 'package:kanooniha/data/body/support/support_request_insert_body.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class AddTicketUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is SupportRequestInsertBody);
    Uri uri = createUri(
        path: SupportApiRoutes.supportRequestInsert,
        body: (data as SupportRequestInsertBody).toJson());
    var response = await tryCatch(future: apiServiceImpl.post(uri),flow: flow);
    if (response != null) {
      flow?.emitData(response);
    }
  }
}
