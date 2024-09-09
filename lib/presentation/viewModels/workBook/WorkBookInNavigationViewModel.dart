import 'package:kanooniha/common/user/UserSessionConst.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/workBook/WorkBookInNavigationResponse.dart';
import 'package:kanooniha/domain/useCase/workBook/newWorkBook/in_app_workBook_useCase.dart';

class WorkBookInNavigationViewModel extends BaseViewModel {
  WorkBookInNavigationViewModel(super.initialState) {
    getWorkBookData();
    logEvent();
  }

  void getWorkBookData() {
    NewWorkBookBody body = NewWorkBookBody(kind: 'WorkbookFirst');
    InAppWorkBookUseCase().invoke(
      flow: MyFlow((appState) {
        if (appState.isSuccess) {
          var data = workBookInNavigationResponseFromJson(appState.getData);
          postSuccess(data: data);
        } else {
          postResult(appState);
        }
      }),
      data: body,
    );
  }

  void refreshStates() => updateScreen(time: DateTime.now().second.toDouble());

  Future<String> getCroupCode(WorkBookInNavigationResponse data) async {
    var gropeCode = await session.getData(UserSessionConst.groupCode);
    if (gropeCode != '') return gropeCode;
    if (data.workBookCourseDetailList?.first != null) {
      var newGroupCode =
          data.workBookCourseDetailList?.first.groupCode?.toString() ?? '';
      if (newGroupCode != '') {
        session.insertData({UserSessionConst.groupCode: newGroupCode});
      }
      return newGroupCode;
    }
    return '';
  }

  @override
  String pageName() => 'workbookFirst';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getWorkBookData();
  }
}
