import 'package:json_annotation/json_annotation.dart';

part 'new_workBook_body.g.dart';

@JsonSerializable(explicitToJson: true)
class NewWorkBookBody {
  final String kind;
  final String? dateValue;

  NewWorkBookBody({
    required this.kind,
    this.dateValue,
  });

  NewWorkBookBody fromJson(Map<String, dynamic> json) =>
      _$NewWorkBookBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NewWorkBookBodyToJson(this);
}
