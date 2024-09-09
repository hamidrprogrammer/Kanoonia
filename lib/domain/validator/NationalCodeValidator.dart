import 'package:kanooniha/domain/validator/ValidationState.dart';
import 'package:kanooniha/domain/validator/Validator.dart';

class NationalCodeValidator extends Validator{
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(
          state: false, msg: 'کدملی را وارد کنید');
    }
    if (data.length < 10) {
      return const ValidationState(
          state: false, msg: 'کدملی وارد شده کمتر از ۱۰ رقم است');
    }
    if (data.length > 11) {
      return const ValidationState(
          state: false, msg: 'کدملی وارد شده صحیح نیست');
    }
    return const ValidationState(state: true);
  }

}