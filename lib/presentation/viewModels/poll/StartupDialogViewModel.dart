import 'package:get/get.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../data/serializer/poll/CheckForPollResponse.dart';
import '../../../domain/useCase/home/NavigationNotifier.dart';
import '../../ui/dialog/StartUpDialogUI.dart';
import '../../uiModel/profile/UserModel.dart';

class StartupDialogViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  StartupDialogViewModel(super.initialState);

  int? count;
  CheckForPollResponse? response;

  void pop() {
    _navigationServiceImpl.pop();
  }

  Future<UserModel> getUserModel() async {
    var userModel = UserModel(
        fullName: await session.getData(UserSessionConst.fullName),
        paye: await session.getData(UserSessionConst.paye),
        currentYear: '',
        iconData: CupertinoIcons.person);
    return userModel;
  }

  Function() get messenger {
    return () async {
      pop();
      var result = await Get.toNamed(AppRoutes.messengerPage);
      count = (count ?? 0) - result as int;
      if (count != null && count! > 0) {
        NavigationNotifier.notifyMessages(count.toString());
      } else {
        NavigationNotifier.notifyMessages('');
      }

      if (count != 0) {
        repeatDialog();
      } else {
        if (response != null) {
          repeatPollDialog();
        }

        updateScreen(time: DateTime.now().millisecond.toDouble());
      }
    };
  }

  void repeatPollDialog() {
    Get.dialog(
        StartupDialogUI(
          response: response,
        ),
        barrierDismissible: false);
  }

  Future<dynamic> repeatDialog() {
    return Get.dialog(
        StartupDialogUI(
          response: response,
          count: count,
        ),
        barrierDismissible: false);
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
