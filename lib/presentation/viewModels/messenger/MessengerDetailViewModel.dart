import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/newMessage/messagesVisitUseCase.dart';

import '../../../core/GetExtensions.dart';
import '../../../data/body/messenger/CreateMessageVisitLogBody.dart';
import '../../../domain/useCase/home/NavigationNotifier.dart';
import '../../uiModel/messenger/MessengerUIModel.dart';

class MessengerDetailViewModel extends BaseViewModel {
  MessengerDetailViewModel(super.initialState) {
    var model = getExtra();
    if (model != null) {
      createLog(model);
    }
    logEvent();
  }

  void createLog(MessengerUIModel model) {
    var body = VisitedMessagesBody(
      MessageId: model.id,
      MessageReference: model.referenceId,
    );

    MessagesVisitUseCase().invoke(
        flow: MyFlow((appState) {
          if (appState.isSuccess) {
            if (model.read == false) {
              NavigationNotifier.notifyMessages('-');
            }
          }
        }),
        data: model.id);
  }

  MessengerUIModel? getExtra() {
    return GetExtensions.getArgs<MessengerUIModel>();
  }

  @override
  String pageName() => 'message_detail';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    var model = getExtra();
    if (model != null) {
      createLog(model);
    }
  }
}
