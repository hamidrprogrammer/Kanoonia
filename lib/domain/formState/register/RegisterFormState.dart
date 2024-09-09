import 'package:kanooniha/domain/formState/MyFormState.dart';

class RegisterFormState extends MyFormState {
  RegisterFormState({
    this.mobile = '',
    this.nationalCode = '',
    this.referredCode,
  });

  String nationalCode, mobile;
  String? referredCode;
}
