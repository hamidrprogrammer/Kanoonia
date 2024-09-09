import 'package:json_annotation/json_annotation.dart';

part 'new_login_body.g.dart';

@JsonSerializable(explicitToJson: true)
class NewLoginBody {
  final String? userName, password, counter, activeCode;

  NewLoginBody(
      {required this.userName,
      this.password = '',
      this.counter = '',
      this.activeCode = ''});



  NewLoginBody fromJson(Map<String, dynamic> json) => _$NewLoginBodyFromJson(json);

  Map<String, dynamic> toJson() {
    return _$NewLoginBodyToJson(this);
  }
}
