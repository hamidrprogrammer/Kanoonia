import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../common/appCommons/appRoutes.dart';
import '../../../core/navigationService/NavigationService.dart';
import '../../../domain/useCase/user/SetPopupSeenUseCase.dart';

class GetPopupMessagesViewModel extends BaseViewModel {
  final _setPopupSeenUseCase = SetPopupSeenUseCase();

  var navigationService = GetIt.I.get<NavigationServiceImpl>();

  GetPopupMessagesViewModel(super.initialState);

  void setLog(int popId) {
    _setPopupSeenUseCase.runJob(
        flow: MyFlow((appState) {
          updateState(appState);
          if (appState.isSuccess) {
            navigationService.pop();
            navigationService.replaceTo(AppRoutes.home);
          }
          if (appState.isFailed) {
            var msg = appState.getErrorModel?.message;
            if (msg != null) {
              messageService.showSnackBar(msg);
            }
          }
        }),
        popId: popId);
  }

  @override
  String pageName() => '';


  @override
  logEvent() {
    // logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
  //
  }
}
