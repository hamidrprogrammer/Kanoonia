import 'package:json_annotation/json_annotation.dart';
import 'package:kanooniha/data/body/BaseBody.dart';

part 'LoginBody.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginBody extends BaseBody {
  LoginBody({
    required this.mobile,
    required this.password,
  });

  final String mobile, password;

  @override
  Map<String, dynamic> toJson() {
    return _$LoginBodyToJson(this);
  }
}
