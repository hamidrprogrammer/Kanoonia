import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/body/exam/ExamAddTargetBody.dart';
import 'package:kanooniha/data/serializer/exam/ExamCourceResponse.dart';

import '../../../core/Notification/MyNotification.dart';
import '../../../data/serializer/exam/AddTargetResponse.dart';
import '../../../domain/useCase/exam/GetExamCourseUseCase.dart';
import '../../../domain/useCase/exam/GetPastExamsUseCase.dart';
import '../../../domain/useCase/exam/SetExamTargetUseCase.dart';

class AddTargetViewModel extends BaseViewModel {
  final MyNotification _notification = GetIt.I.get<MyNotification>();

  MessagingServiceImpl messagingServiceImpl =
      GetIt.I.get<MessagingServiceImpl>();
  Map<int, AppState> courses = {};
  Map<int, double> values = {};
  int selectedDate = 0;
  final _setExamTargetUseCase = SetExamTargetUseCase();

  AddTargetViewModel(super.initialState) {
    getPastExams();
  }

  var getPastExamsUseCase = GetPastExamsUseCase();
  var getExamCoursesUseCase = GetExamCourseUseCase();
  AppState datesState = AppState.idle;
  AppState examState = AppState.idle;

  void getPastExams() {
    getPastExamsUseCase.invoke(
      flow: MyFlow(
        (value) {
          datesState = value;
          if (datesState.isSuccess) {
            chooseLastExam();
          }
          updateScreen(time: DateTime.now().millisecond.toDouble());
        },
      ),
    );
  }

  void chooseLastExam() async {
    var dateAsString = await session.getData(UserSessionConst.lastTargetDate);
    if (dateAsString.isNotEmpty) {
      var dateAsInt = int.tryParse(dateAsString);
      if (dateAsInt != null) {
        selectedDate = dateAsInt;
        getExamCourses(dateAsInt);
        // updateScreen(time: DateTime.now().millisecond.toDouble());
      }
    }
  }

  void saveLastExamDate(String date) {
    session.insertData({UserSessionConst.lastTargetDate: date});
  }

  Function(int?) onTimesChanged() {
    return (value) {
      if (value != null) {
        selectedDate = value;
        getExamCourses(value);
      }
    };
  }

  void getExamCourses(int testDate) {
    selectedDate = testDate;
    getExamCoursesUseCase.getByTestDate(
      testDate: testDate,
      flow: MyFlow(
        (value) {
          if (value.isSuccess) {
            saveLastExamDate(testDate.toString());
            ExamCourceResponse response = value.getData;
            courses.clear();
            values.clear();
            response.data?.courses?.forEach((element) {
              courses[element.courseId?.toInt() ?? 0] =
                  element.preTarget != null
                      ? AppState.success(5)
                      : AppState.idle;

              double percent =
                  element.preTarget != null ? getPercent(element) : 0.0;
              values[element.courseId?.toInt() ?? 0] =
                  element.preTarget != null ? percent : 5;
            });
          }
          examState = value;
          updateScreen(time: DateTime.now().millisecond.toDouble());
        },
      ),
    );
  }

  double getPercent(Courses element) {
    var percent = (element.preTarget?.targetPercent ?? 50) / 10;
    // var index = element.preTarget?.targetIndex?.toDouble() ?? 0;
    // var percent = (((index - 5000) * element.sigma) / 1000) +
    //     (element.averagePercent ?? 0);
    // if(percent > 10){
    //   percent = 10;
    // }
    // if(percent < 0){
    //   percent = 0;
    // }
    // Logger.d('value is $percent');
    return percent;
  }

  MapEntry<int, AppState> getMapState(int courseId) {
    return courses.entries.firstWhere(
      (element) => element.key == courseId,
      orElse: () => MapEntry(0, AppState.idle),
    );
  }

  MapEntry<int, double> getSliderValue(int courseId) {
    return values.entries.firstWhere(
      (element) => element.key == courseId,
      orElse: () => const MapEntry(0, .5),
    );
  }

  Future<ExamAddTargetBody> createBody(
      int courseId, int percent, String taraz) async {
    var targetBody = ExamAddTargetBody(
      userId: await session.getData(UserSessionConst.id),
      CourseId: courseId,
      TargetIndex: taraz,
      TargetPercent: percent,
    );
    return targetBody;
  }

  void setTarget(int courseId, int percent, String taraz) async {
    var state = getState(courseId);
    if (state.isLoading) return;
    // if (state.isSuccess || state.isLoading) return;
    var body = await createBody(courseId, percent, taraz);
    _setExamTargetUseCase.setExamTarget(
      body: body,
      flow: MyFlow(
        (state) {
          updateCourseState(courseId, state);
          updateScreen(time: DateTime.now().millisecond.toDouble());
          if (state.isSuccess && state.getData is AddTargetResponse) {
            messagingServiceImpl.showSnackBar(
                (state.getData as AddTargetResponse).data?.message ?? '');
            _notification.publish('ExamsViewModel', true);
          }
          if (state.isFailed) {
            messagingServiceImpl
                .showSnackBar(state.getErrorModel?.message ?? '');
          }
        },
      ),
    );
  }

  AppState getState(int courseId) {
    return getMapState(courseId).value;
  }

  void updateCourseState(int courseId, AppState appState) {
    courses[courseId] = appState;
  }

  Function(dynamic) onValueChanged(int courseId) {
    return (value) {
      if (value is double) {
        updateValueState(courseId, value);
      }
    };
  }

  void updateValueState(int courseId, double value) {
    values[courseId] = value;
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  @override
  String pageName() => '';

  @override
  logEvent() {
    // logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
   getPastExams();
  }
}
