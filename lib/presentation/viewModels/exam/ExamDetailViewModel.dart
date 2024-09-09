import 'package:get/get.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/presentation/uiModel/exam/ExamDetailMenuObject.dart';

import '../../../common/user/UserSessionConst.dart';
import '../../../core/GetExtensions.dart';
import '../../../core/Logger.dart';
import '../../../domain/useCase/exam/GetExamDetailUseCase.dart';

class ExamDetailViewModel extends BaseViewModel {
  final _getExamDetailUseCase = GetExamDetailUseCase();
  late int testDate;

  ExamDetailViewModel(super.initialState) {
    getExtra();
    logEvent();
  }

  void getExtra() {
    testDate = GetExtensions.getArgs<int>() ?? 0;
    if (testDate != 0) {
      getExamDetail(testDate);
    }
  }

  void getExamDetail(int testDate) {
    _getExamDetailUseCase.getByTestDate(
        testDate: testDate,
        flow: MyFlow((state) {
          postResult(state);
        }));
  }

  Future<bool> getUserModel() async {
    Logger.d(
        'current showChart is ${session.getData(UserSessionConst.showChart).isBlank!}');
    return await session.getData(UserSessionConst.showChart) == "1";
  }

  getExamDetailObject() => ExamDetailMenuObject(testDate);

  @override
  String pageName() => 'exam_detail';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getExtra();
  }
}
