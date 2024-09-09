import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/newMessage/messagesListUseCase.dart';

import '../../uiModel/messenger/MessengerUIModel.dart';

class HomeMessagesViewModel extends BaseViewModel {
  final _navigationService = GetIt.I.get<NavigationServiceImpl>();
  var count = 0;

  HomeMessagesViewModel(super.initialState) {
    fetchMessagesList();
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
  String pageName() => '';

  @override
  logEvent() {
    // logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    fetchMessagesList();
  }
}
