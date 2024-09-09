// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLoginBody _$NewLoginBodyFromJson(Map<String, dynamic> json) => NewLoginBody(
      userName: json['userName'] as String?,
      password: json['password'] as String? ?? '',
      counter: json['counter'] as String? ?? '',
      activeCode: json['activeCode'] as String? ?? '',
    );

Map<String, dynamic> _$NewLoginBodyToJson(NewLoginBody instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'counter': instance.counter,
      'activeCode': instance.activeCode,
    };
