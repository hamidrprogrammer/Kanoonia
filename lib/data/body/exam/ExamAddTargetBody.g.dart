// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExamAddTargetBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamAddTargetBody _$ExamAddTargetBodyFromJson(Map<String, dynamic> json) =>
    ExamAddTargetBody(
      userId: json['userId'] as String,
      CourseId: json['CourseId'] as int,
      TargetIndex: json['TargetIndex'] as String,
      TargetPercent: json['TargetPercent'] as int,
    );

Map<String, dynamic> _$ExamAddTargetBodyToJson(ExamAddTargetBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'TargetIndex': instance.TargetIndex,
      'CourseId': instance.CourseId,
      'TargetPercent': instance.TargetPercent,
    };
