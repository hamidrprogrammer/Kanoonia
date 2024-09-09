import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/newMessage/messagesListUseCase.dart';

import '../../uiModel/messenger/MessengerUIModel.dart';

class FetchAllMessagesListViewModel extends BaseViewModel {
  final _navigationService = GetIt.I.get<NavigationServiceImpl>();
  var count = 0;

  FetchAllMessagesListViewModel(super.initialState) {
    fetchMessagesList();
    logEvent();
  }

  Future<dynamic>? navigate(MessengerUIModel model) {
    if (!model.read) {
      count += 1;
    }
    return _navigationService.navigateTo(AppRoutes.messengerDetailPage, model);
  }

  void fetchMessagesList({bool withState = true}) {
    MessagesListUseCase().invoke(flow: MyFlow((appState) {
      if (withState) {
        postResult(appState);
      } else {
        if (appState.isSuccess) {
          postResult(appState);
        }
      }
    }));
  }

  @override
  String pageName() => 'all_messages';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
   fetchMessagesList();
  }
}
