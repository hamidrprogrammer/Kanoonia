import 'package:json_annotation/json_annotation.dart';

part 'userLoginRefreshBody.g.dart';

@JsonSerializable(explicitToJson: true)
class UserLoginRefreshBody {
  final String token, refreshToken;

  const UserLoginRefreshBody({
    required this.token,
    required this.refreshToken,
  });

  UserLoginRefreshBody fromJson(Map<String, dynamic> json) =>
      _$UserLoginRefreshBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRefreshBodyToJson(this);
}
