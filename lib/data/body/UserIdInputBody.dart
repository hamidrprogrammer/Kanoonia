import 'package:kanooniha/data/body/BaseBody.dart';

class UserIdInputBody extends BaseBody {
  UserIdInputBody({required this.userId});

  final String userId;

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId};
  }
}
