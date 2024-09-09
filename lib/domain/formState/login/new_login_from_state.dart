import 'package:kanooniha/data/body/login/newLogin/new_login_body.dart';

class NewLoginFormState {
  String userName, password, counter, activeCode;

  NewLoginFormState({
    this.userName = '',
    this.password = '',
    this.counter = '',
    this.activeCode = '',
  });

  NewLoginBody get createBody => NewLoginBody(
      userName: userName,
      counter: counter,
      activeCode: activeCode,
      password: password);
}
