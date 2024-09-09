import 'package:json_annotation/json_annotation.dart';

import '../BaseBody.dart';

part 'TargetExamItem.g.dart';

@JsonSerializable(explicitToJson: true)
class TargetExamItem extends BaseBody {
  final int CourseId, TargetPercent;
  final String TargetIndex;

  TargetExamItem({
    required this.CourseId,
    required this.TargetIndex,
    required this.TargetPercent,
  });

  @override
  Map<String, dynamic> toJson() {
    return _$TargetExamItemToJson(this);
  }

  static fromJson(Map<String, dynamic> json) {
    return _$TargetExamItemFromJson(json);
  }
}
