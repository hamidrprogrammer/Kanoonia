import 'package:kanooniha/data/serializer/easyQuestion/EasyQuestionItem.dart';

class EasyQuestionUiModel {
  final List<EasyQuestionModel> data;
  final List<String> courses;
  final List<int> ids;

  const EasyQuestionUiModel({
    required this.data,
    required this.courses,
    required this.ids,
  });
}

class EasyQuestionModel {
  final int id, testDate;
  final List<int> trues, falses, notCompletes;
  final String name;

  const EasyQuestionModel({
    required this.id,
    required this.name,
    required this.trues,
    required this.falses,
    required this.notCompletes,
    required this.testDate,
  });

  EasyQuestionModel plus(EasyQuestionModel item) {
    return EasyQuestionModel(
      id: id,
      name: name,
      testDate: testDate,
      trues: trues + item.trues,
      falses: falses + item.falses,
      notCompletes: notCompletes + item.notCompletes,
    );
  }
}

extension EasyQuestionExtension on EasyQuestionItemResponse {
  EasyQuestionModel createEasyQuestionModel() {
    return EasyQuestionModel(
      id: courseId,
      name: courseName,
      testDate: testDate,
      falses:answer == 0 ? [] : isWrong == 1 ? [questionNo] : [],
      trues:answer == 0 ? [] : isWrong == 0 ? [questionNo] : [],
      notCompletes: answer == 0 ? [questionNo] : [],
    );
  }
}
