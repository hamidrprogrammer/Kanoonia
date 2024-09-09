import 'NetworkConsts.dart';

class ExamApiRoutes {
  static const getInformationOfNextUserTest =
      '${NetworkConsts.BasePath}/GetInformationOfNextUserTest';

  static const getUserPastTestDates =
      '${NetworkConsts.BasePath}/GetUserPastTestDates';

  //changed base url
  static const getTestIndexCourses =
      '${NetworkConsts.BasePath}/GetTestIndexCourses';

  static const setTargetLevelForUserCourses =
      '${NetworkConsts.BasePath}/SetTargetLevelForUserCourses';

  static const getUserTestInfo = '${NetworkConsts.BasePath}/GetUserTestInfo';
  static const getEasyQuestion = '${NetworkConsts.BasePath}/GetEasyQuestionList';
}
