import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../uiModel/profile/UserModel.dart';

class UpdateViewModel extends BaseViewModel {
  UpdateViewModel(super.initialState);

  Future<UserModel> getUserModel() async {
    var userModel = UserModel(
        fullName: await session.getData(UserSessionConst.fullName),
        paye: await session.getData(UserSessionConst.paye),
        currentYear: '',
        iconData: CupertinoIcons.person);
    return userModel;
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
