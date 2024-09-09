import 'package:json_annotation/json_annotation.dart';
import 'package:kanooniha/data/body/BaseBody.dart';

part 'VerificationBody.g.dart';

@JsonSerializable(explicitToJson: true)
class VerificationBody extends BaseBody {
  VerificationBody({required this.mobile});

  final String mobile;

  @override
  Map<String, dynamic> toJson() {
    return _$VerificationBodyToJson(this);
  }
}
