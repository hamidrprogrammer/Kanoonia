import 'package:kanooniha/domain/formState/MyFormState.dart';

class VerificationFormState extends MyFormState {
  VerificationFormState(
      {this.code = '', this.mobile = '', this.enteredCode = ''});

  String code, mobile, enteredCode;

  @override
  String toString() {
    return {
      'code':code,
      'mobile':mobile,
      'enteredCode':enteredCode,
    }.toString();
  }
}
