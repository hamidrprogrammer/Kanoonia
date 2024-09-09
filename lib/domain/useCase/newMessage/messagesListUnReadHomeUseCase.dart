import 'package:kanooniha/common/network/message/MessageApiRoutes.dart';
import 'package:kanooniha/data/serializer/newMessages/messageItem.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

class MessagesListUnReadHomeUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: MessageApiRoutes.messagesListUnReadHome);
    var response = await tryCatch(future: apiServiceImpl.get(uri),flow: flow);
    if (response != null) {
      flow?.emitData(newMessageItemsFromJson(response));
    }
  }
}
