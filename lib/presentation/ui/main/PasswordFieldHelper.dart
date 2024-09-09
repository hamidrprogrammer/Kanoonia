import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/domain/validator/login/PasswordValidator.dart';

class PasswordFieldHelper extends StatefulWidget {
  const PasswordFieldHelper({Key? key, required this.onChangeValue})
      : super(key: key);
  final Function(String) onChangeValue;

  @override
  State<PasswordFieldHelper> createState() => _PasswordFieldHelperState();
}

class _PasswordFieldHelperState extends State<PasswordFieldHelper> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: const Text('رمز عبور',textAlign: TextAlign.start),
        hintText: 'گذرواژه خود را وارد نمایید',
        prefixIcon: const Icon(CupertinoIcons.lock_fill),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          ),
        ),
        hintTextDirection: TextDirection.rtl,
          alignLabelWithHint: true,
        helperText: 'رمز عبور همان رمز عبور سایت کانون می باشد',
      ),
      obscureText: obscureText,
      onChanged: widget.onChangeValue,
      validator: (value) => PasswordValidator().validate(value ?? '').msg,
      textAlign: TextAlign.left,
    );
  }
}
