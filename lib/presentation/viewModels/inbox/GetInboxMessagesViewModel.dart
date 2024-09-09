import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/article/articles_UseCase.dart';

import '../../../domain/useCase/inbox/AddActionToInboxItemUseCase.dart';

class GetInboxMessagesViewModel extends BaseViewModel {
  GetInboxMessagesViewModel(super.initialState) {
    getMessages();
    logEvent();
  }

  void getMessages() {
    ArticlesUseCase().invoke(flow: mainFlow);
  }

  void addSeenFunc(num? itemId) {
    if (itemId != null) {
      var id = itemId.toInt();
      AddActionToInboxItemUseCase().addActionToInboxItem(id);
    }
  }

  @override
  String pageName() => 'news';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getMessages();
    logEvent();
  }
}
