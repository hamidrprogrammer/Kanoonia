import 'package:flutter/material.dart';
import 'package:kanooniha/domain/validator/Validator.dart';

class TextFormFieldHelper extends StatelessWidget {
  const TextFormFieldHelper({
    Key? key,
    required this.label,
    required this.hint,
    this.icon,
    required this.keyboardType,
    required this.onChangeValue,
    this.validator,
    this.maxLength,
    this.initValue,
    this.maxLine,
    this.minLine,
    this.textAlign = TextAlign.start,
    this.expand = false,
    this.enable = true,
    this.onTap,
    this.controller,
    this.textInputAction,
  }) : super(key: key);
  final String label;
  final String? initValue;
  final String hint;
  final IconData? icon;
  final Validator? validator;
  final TextInputType keyboardType;
  final Function(String) onChangeValue;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final TextAlign textAlign;
  final bool expand;
  final bool enable;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      textInputAction: textInputAction,
      controller: controller,
      onTap: onTap,
      textAlign: textAlign,
      initialValue: initValue,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(label, textAlign: TextAlign.start),
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        hintTextDirection: TextDirection.rtl,
        alignLabelWithHint: true,
      ),
      maxLength: maxLength,
      validator: (value) => validator?.validate(value ?? '').msg,
      keyboardType: keyboardType,
      onChanged: onChangeValue,
      expands: expand,
      maxLines: maxLine,
      minLines: minLine,
      textAlignVertical: TextAlignVertical.top,
    );
  }
}
