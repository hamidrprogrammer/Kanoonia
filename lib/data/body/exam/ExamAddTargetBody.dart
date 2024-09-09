import 'package:json_annotation/json_annotation.dart';
import 'package:kanooniha/data/body/BaseBody.dart';

part 'ExamAddTargetBody.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamAddTargetBody extends BaseBody {
  final String userId, TargetIndex;
  final int CourseId, TargetPercent;

  ExamAddTargetBody({
    required this.userId,
    required this.CourseId,
    required this.TargetIndex,
    required this.TargetPercent,
  });

  @override
  Map<String, dynamic> toJson() {
    return _$ExamAddTargetBodyToJson(this);
  }
}
