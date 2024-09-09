import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../uiModel/profile/UserModel.dart';

class StartupMessagesDialogViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  StartupMessagesDialogViewModel(super.initialState);

  void pop() {
    _navigationServiceImpl.pop();
  }


  Function() messenger() {
    return () {
      pop();
      _navigationServiceImpl.navigateTo(AppRoutes.messengerPage);
    };
  }

  @override
  String pageName() => '';

  @override
  logEvent() {
    // logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    // TODO: implement onReloadClick
  }
}
