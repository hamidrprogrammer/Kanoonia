import 'package:core/storage/shared/LocalSessionImpl.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/easyQuestion/easyQuestionUseCase.dart';
import 'package:kanooniha/presentation/uiModel/easyQuestion/EasyQuestionModel.dart';

class EasyQuestionsViewModel extends BaseViewModel {
  AppState uiState = AppState.idle;
  final LocalSessionImpl _localSessionImpl = GetIt.I.get();
  EasyQuestionUiModel items =
      const EasyQuestionUiModel(data: [], courses: [], ids: []);

  String? selectedCourse;

  // late String selectedQuestion;

  EasyQuestionsViewModel(super.initialState) {
    getQuestions();
    logEvent();
  }

  void getQuestions() async {
    EasyQuestionUseCase().getWorkBookByBody(
      flow: MyFlow(
        (appState) {
          if (appState.isSuccess) {
            items = appState.getData;
            if (items.courses.isNotEmpty) {
              selectedCourse = items.courses.first;
            }
          }
          uiState = appState;
          refresh();
        },
      ),
    );
  }

  List<EasyQuestionModel> get currentModel => items.data
      .where((element) => (element.name == selectedCourse) == true)
      .toList();

  // onQuestionsChange(String? newSelectedQuestion) =>
  //     selectedQuestion =
  //         newSelectedQuestion ?? '';

  onCourseChange(String? p1) {
    selectedCourse = p1;
    refresh();
  }

  void refresh() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  @override
  String pageName() => 'workBook_easyQuestions';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getQuestions();
  }
}
