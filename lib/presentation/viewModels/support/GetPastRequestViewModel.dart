import 'package:kanooniha/core/flow/MyFlow.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../domain/useCase/support/GetPastRequestUseCase.dart';

class GetPastRequestViewModel extends BaseViewModel {
  GetPastRequestViewModel(super.initialState) {
    getMessages();
    logEvent();
  }

  final _getPastRequestUseCase = GetPastRequestUseCase();

  void getMessages() {
    _getPastRequestUseCase.invoke(flow: MyFlow( (appState) {
      postResult(appState);
    }));
  }

  @override
  String pageName() => 'supportList_page';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getMessages();
  }
}
