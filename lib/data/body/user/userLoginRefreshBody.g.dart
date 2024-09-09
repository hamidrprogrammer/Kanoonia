// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLoginRefreshBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRefreshBody _$UserLoginRefreshBodyFromJson(
        Map<String, dynamic> json) =>
    UserLoginRefreshBody(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$UserLoginRefreshBodyToJson(
        UserLoginRefreshBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
