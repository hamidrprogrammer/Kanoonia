// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPollBody _$SetPollBodyFromJson(Map<String, dynamic> json) => SetPollBody(
      uniqueId: json['uniqueId'] as String,
      pollDetailId: json['pollDetailId'] as String,
      answer: json['answer'] as String?,
      selectedOption: json['selectedOption'] as String?,
      checkedOptions: (json['checkedOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SetPollBodyToJson(SetPollBody instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'pollDetailId': instance.pollDetailId,
      'answer': instance.answer,
      'selectedOption': instance.selectedOption,
      "checkedOptions": instance.checkedOptions,
    };
