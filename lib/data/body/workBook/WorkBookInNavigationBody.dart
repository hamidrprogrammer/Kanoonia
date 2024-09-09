import 'package:kanooniha/data/body/BaseBody.dart';

class WorkBookInNavigationBody extends BaseBody {
  final String userid, testDate;

  WorkBookInNavigationBody({
    required this.userid,
    required this.testDate,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "testDate": testDate,
    };
  }
}
