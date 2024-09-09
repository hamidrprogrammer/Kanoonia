import 'package:kanooniha/common/network/message/MessageApiRoutes.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class MessagesVisitUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is String);
    var uri = createUri(
        path: MessageApiRoutes.messagesVisit, body: {'messageId': data});
    var response = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
    if (response != null) {
      flow?.emitData('');
    }
  }
}
