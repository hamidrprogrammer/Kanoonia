import 'package:flutter/widgets.dart';
import 'package:kanooniha/domain/validator/ValidationState.dart';
import 'package:kanooniha/domain/validator/Validator.dart';

class MobileValidator extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل را وارد کنید');
    }
    if (data.length < 11) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل وارد شده کمتر از ۱۱ رقم است');
    }
    if (!data.startsWith('09')) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل وارد شده صحیح نیست.');
    }
    return const ValidationState(state: true);
  }

  static TextInputType mobileInputType = TextInputType.phone;
}
