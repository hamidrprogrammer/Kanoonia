import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/user/login/getUserInfoUseCase.dart';

class UserAppBarViewModel extends BaseViewModel {
  UserAppBarViewModel(super.initialState) {
    fetchUserData();
  }

  @override
  logEvent() {}

  @override
  String pageName() => '';

  void fetchUserData() {
    GetUserInfoUseCase().invoke(flow: mainFlow);
  }

  @override
  onReloadClick() {
    fetchUserData();
  }
}
