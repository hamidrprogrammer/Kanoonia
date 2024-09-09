import 'package:kanooniha/core/GetExtensions.dart';
import 'package:kanooniha/core/flow/MyFlow.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../domain/useCase/workBook/GetWorkBookCommentUseCase.dart';

class GetWorkBookCommentViewModel extends BaseViewModel {
  final int testDateExtra;
  final _getWorkBookCommentUseCase = GetWorkBookCommentUseCase();

  GetWorkBookCommentViewModel(super.initialState, this.testDateExtra) {
    getWorkBookComments(testDate: testDateExtra);
  }

  void getWorkBookComments({required int testDate}) {
    _getWorkBookCommentUseCase.getByTestDate(
        testDate: testDate,
        flow: MyFlow( (appState) {
          postResult(appState);
        }));
  }

  void getExtra() {
    var testDateExtra = GetExtensions.getArgs<int>();
    if (testDateExtra != null) {
      getWorkBookComments(testDate: testDateExtra);
    }
  }

  @override
  String pageName() => '';

  @override
  logEvent() {
    // logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getWorkBookComments(testDate: testDateExtra);
  }
}
