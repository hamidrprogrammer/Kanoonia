// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) => RegisterBody(
      RoleId: json['RoleId'] as String,
      Mobile: json['Mobile'] as String,
      NationalCode: json['NationalCode'] as String,
      Recommender: json['Recommender'] as String?,
    );

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'Mobile': instance.Mobile,
      'NationalCode': instance.NationalCode,
      'Recommender': instance.Recommender,
      'RoleId': instance.RoleId,
    };
