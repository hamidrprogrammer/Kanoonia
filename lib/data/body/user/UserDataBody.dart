import 'package:kanooniha/data/body/BaseBody.dart';

class UserDataBody extends BaseBody {
  final String userId;
  final String privateKey;

  UserDataBody({
    required this.userId,
    required this.privateKey
  });

  @override
  Map<String, dynamic> toJson() {
    return {"userId": userId, "privateKey": privateKey};
  }
}
