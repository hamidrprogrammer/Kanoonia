import 'package:kanooniha/data/body/BaseBody.dart';

class GetWorkBookBody extends BaseBody {
  final String userId, testDate, kindId;

  GetWorkBookBody({
    required this.userId,
    required this.testDate,
    required this.kindId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'testDate': testDate,
      'kindId': kindId,
    };
  }
}
