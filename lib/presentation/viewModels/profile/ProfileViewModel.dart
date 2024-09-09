import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/user/login/getUserInfoUseCase.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(super.initialState) {
    fetchUserData();
    logEvent();
  }

  void fetchUserData() {
    GetUserInfoUseCase().invoke(flow: mainFlow);
  }

  final _navigationService = GetIt.I.get<NavigationServiceImpl>();

  Function() navigateToAddTargetPage() {
    return () {
      _navigationService.navigateTo(AppRoutes.addTestTargetPage);
    };
  }

  @override
  String pageName() => 'profile';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    fetchUserData();
  }
}
