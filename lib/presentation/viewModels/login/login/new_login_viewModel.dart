import 'package:flutter/widgets.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/serializer/user/LoginSerializer.dart';
import 'package:kanooniha/domain/formState/login/new_login_from_state.dart';
import 'package:kanooniha/domain/useCase/user/login/new_login_use_case.dart';
import 'package:kanooniha/presentation/uiModel/login/loginFormModel.dart';

class NewLoginViewModel extends BaseViewModel {
  NewLoginViewModel(super.initialState);

  NewLoginFormState formState = NewLoginFormState();

  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  final formKey = GlobalKey<FormState>();

  onChangeNationalCode(String code) => formState.userName = code;

  void submitCode() {
    if (state.isLoading) return;
    if (formKey.currentState?.validate() == true) {
      NewLoginUseCase().invoke(
          flow: MyFlow((appState) {
            postResult(appState);
            if (appState.isSuccess && appState.getData is LoginSerializer) {
              LoginSerializer loginData = appState.getData;
              if(loginData.loginBy == 'mobile'){
                sendCode(loginData.createLoginFormModel(formState.userName));
              }else{
                _navigationServiceImpl.navigateTo(
                  AppRoutes.loginForm,
                  (appState.getData as LoginSerializer)
                      .createLoginFormModel(formState.userName),
                );
              }

            }
            if (appState.isFailed) handleFailed(appState);
          }),
          data: formState.createBody);
    }
  }


  void sendCode(LoginFormModel? formModel) {
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
  String pageName() => 'input_login';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    //
  }
}
