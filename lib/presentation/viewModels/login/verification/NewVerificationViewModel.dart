import 'package:flutter/material.dart';
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

class NewVerificationViewModel extends BaseViewModel {
  var formKey = GlobalKey<FormState>();

  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  NewLoginFormState formState = NewLoginFormState();
  LoginFormModel? formModel;

  NewVerificationViewModel(super.initialState) {
    getExtra();
    logEvent();
  }

  Function(String) get onCodeChange => (value) => formState.activeCode = value;

  void getExtra() {
    formModel = _navigationServiceImpl.getArgs();
    if (formModel == null) {
      _navigationServiceImpl.replaceTo(AppRoutes.login);
    } else {
      formState.userName = formModel?.nationalCode ?? '';
    }
  }

  bool get isValid => formKey.currentState?.validate() == true;

  void submitCode() {
    if (state.isLoading) return;
    if (isValid) {
      NewLoginUseCase().invoke(
          flow: MyFlow((appState) async {
            postResult(appState);
            if (appState.isSuccess && appState.getData is LoginSerializer) {
              LoginSerializer userData = appState.getData;
              await saveUserData(userData);
              _navigationServiceImpl.off(AppRoutes.home);
            }
          }),
          data: formState.createBody);
    }
  }

  Future<bool> saveUserData(LoginSerializer userData) async {
    await session.insertData({
      UserSessionConst.token: userData.tokenJwt ?? '',
      UserSessionConst.refreshToken: userData.tokenRefresh ?? '',
    });
    RefreshTokenInterceptorUseCase().invoke();
    return Future.value(true);
  }

  @override
  String pageName() => 'verification';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    //
  }
}
