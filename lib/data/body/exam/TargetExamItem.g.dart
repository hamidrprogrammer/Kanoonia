// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TargetExamItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TargetExamItem _$TargetExamItemFromJson(Map<String, dynamic> json) =>
    TargetExamItem(
      CourseId: json['CourseId'] as int,
      TargetIndex: json['TargetIndex'] as String,
      TargetPercent: json['TargetPercent'] as int,
    );

Map<String, dynamic> _$TargetExamItemToJson(TargetExamItem instance) =>
    <String, dynamic>{
      'CourseId': instance.CourseId,
      'TargetPercent': instance.TargetPercent,
      'TargetIndex': instance.TargetIndex,
    };
