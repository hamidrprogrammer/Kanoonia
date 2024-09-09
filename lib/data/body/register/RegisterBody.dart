import 'package:json_annotation/json_annotation.dart';
import 'package:kanooniha/data/body/BaseBody.dart';

part 'RegisterBody.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterBody extends BaseBody {
  RegisterBody({
    required this.RoleId,
    required this.Mobile,
    required this.NationalCode,
    this.Recommender,
  });

  String Mobile, NationalCode;
  String? Recommender;
  String RoleId;


  @override
  Map<String, dynamic> toJson() =>
      _$RegisterBodyToJson(this);

}

