import 'package:core/downloader/MyDownloader.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../data/serializer/toolBox/GetTestToolBoxResponse.dart';
import '../../../domain/useCase/workBook/GetTestToolBoxUseCase.dart';

class GetTestToolBoxViewModel extends BaseViewModel {
  final int testDateExtra;
  final _getTestToolBoxUseCase = GetTestToolBoxUseCase();

  GetTestToolBoxViewModel(super.initialState, this.testDateExtra) {
    getTestToolBox(testDate: testDateExtra);
  }

  void getTestToolBox({required int testDate}) {
    _getTestToolBoxUseCase.getByTestDate(
        testDate: testDate,
        flow: MyFlow((appState) {
          postResult(appState);
        }));
  }

  onDownloadClick(TestToolBox? toolBoxItem) {
    if (toolBoxItem != null && toolBoxItem.fileUrl != null) {
      MyDownloader.openUrl(link: toolBoxItem.fileUrl!);
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
    getTestToolBox(testDate: testDateExtra);

  }

}
