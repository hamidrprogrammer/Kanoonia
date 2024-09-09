import 'package:kanooniha/domain/validator/ValidationState.dart';
import 'package:kanooniha/domain/validator/Validator.dart';

class AddTicketDescriptionValidation extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return const ValidationState(
          state: false, msg: 'توضیحات مشکل را وارد کنید');
    }
    return const ValidationState(state: true);
  }
}
