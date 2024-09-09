import '../MyFormState.dart';

class LoginFormState extends MyFormState {
  LoginFormState({
    this.mobile = '',
    this.mobileError,
    this.password = '',
    this.passwordError,
  });

  String mobile;
  String? mobileError;
  String password;
  String? passwordError;
}
