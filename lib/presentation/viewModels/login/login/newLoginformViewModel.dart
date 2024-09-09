import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/serializer/user/LoginSerializer.dart';
import 'package:kanooniha/domain/formState/login/new_login_from_state.dart';
import 'package:kanooniha/domain/useCase/app/refresh_token_interceptor_use_case.dart';
import 'package:kanooniha/domain/useCase/user/login/new_login_use_case.dart';
import 'package:kanooniha/presentation/uiModel/login/loginFormModel.dart';
import 'package:kanooniha/presentation/uiModel/login/login_form_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLoginFormViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  NewLoginFormState formState = NewLoginFormState();

  NewLoginFormViewModel(super.initialState) {
    getExtra();
  }

  LoginFormModel? formModel;

  void getExtra() {
    formModel = _navigationServiceImpl.getArgs();
    if (formModel == null) {
      _navigationServiceImpl.off(AppRoutes.login);
    } else {
      formState.userName = formModel?.nationalCode ?? '';
    }
  }

  onPasswordChange(String psw) => formState.password = psw;

  onCounterChange(String counter) => formState.counter = counter;

  void submitLogin() {
    if (state.isLoading) return;
    if (formModel?.loginBy == LoginFormEnum.password &&
        formState.password == '') {
      messageService.showSnackBar('لطفا گذرواژه خود را وارد نمایید.');
      return;
    }
    if (formModel?.loginBy == LoginFormEnum.counter &&
        formState.counter == '') {
      messageService.showSnackBar('لطفا شمارنده خود را وارد نمایید.');
      return;
    }
    NewLoginUseCase().invoke(
        flow: MyFlow((appState) async {
          print("tokenJwt");
          postResult(appState);
          if (appState.isSuccess && appState.getData is LoginSerializer) {
            LoginSerializer userData = appState.getData;
            if (userData.tokenJwt != null && userData.tokenRefresh != null) {
              print("tokenJwt");
              print(userData.tokenJwt);
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("tokenJwt", userData.tokenJwt.toString());
              await saveUserData(userData);
              // await FireBaseApi().updateFireBaseToken();
              _navigationServiceImpl.off(AppRoutes.home);
            } else {
              _navigationServiceImpl.pop();
            }
          }
          if (appState.isFailed) handleFailed(appState);
        }),
        data: formState.createBody);
  }

  Future<bool> saveUserData(LoginSerializer userData) async {
    await session.insertData({
      UserSessionConst.token: userData.tokenJwt ?? '',
      UserSessionConst.refreshToken: userData.tokenRefresh ?? '',
    });
    RefreshTokenInterceptorUseCase().invoke();
    return Future.value(true);
  }

  void sendCode() {
    if (state.isLoading) return;
    var data = formState;
    data.activeCode = formModel?.mobileToken ?? '';
    NewLoginUseCase().invoke(
      flow: MyFlow((appState) {
        postResult(appState);
        if (appState.isSuccess) {
          if (appState.getData is LoginSerializer) {
            LoginSerializer loginSerializer = appState.getData;
            messageService.showSnackBar(loginSerializer.message ?? '');
          }

          _navigationServiceImpl.replaceTo(AppRoutes.verification, formModel);
        }
        if (appState.isFailed) handleFailed(appState);
      }),
      data: data.createBody,
    );
  }

  @override
  String pageName() => 'login';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    //
  }
}
