import 'package:json_annotation/json_annotation.dart';
import 'package:kanooniha/data/body/BaseBody.dart';

part 'ForgetPasswordBody.g.dart';

@JsonSerializable(explicitToJson: true)
class ForgetPasswordBody extends BaseBody {
  ForgetPasswordBody({required this.mobile});

  final String mobile;

  @override
  Map<String, dynamic> toJson() {
    return _$ForgetPasswordBodyToJson(this);
  }
}
