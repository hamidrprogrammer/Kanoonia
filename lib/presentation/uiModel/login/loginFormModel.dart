import 'package:kanooniha/data/serializer/user/LoginSerializer.dart';

import 'login_form_enum.dart';

class LoginFormModel {
  final String nationalCode, mobileToken, token, refreshToken;
  final LoginFormEnum loginBy;
  final bool mobile;

  const LoginFormModel({
    required this.nationalCode,
    required this.mobileToken,
    required this.token,
    required this.refreshToken,
    required this.loginBy,
    required this.mobile,
  });
}

extension LoginResponseExtension on LoginSerializer {
  LoginFormModel createLoginFormModel(String nationalCode) =>
      LoginFormModel(
        nationalCode: nationalCode,
        mobileToken: mobileToken ?? '',
        token: tokenJwt ?? '',
        refreshToken: tokenRefresh ?? '',
        loginBy: loginBy == 'Password'
            ? LoginFormEnum.password
            : LoginFormEnum.counter,
        mobile: mobile == true,
      );
}
