import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:core/downloader/MyDownloader.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/workBook/newWorkBook/NewWorkBookSerializer.dart';
import 'package:kanooniha/domain/useCase/workBook/newWorkBook/newWorkBookUseCase.dart';

class DownloadWorkBookViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationService = GetIt.I.get();

  DownloadWorkBookViewModel(super.initialState) {
    logEvent();
  }

  void getWorkBook(NewWorkBookBody body) {
    if (state.isLoading) return;
    NewWorkBookUseCase().invoke(
        flow: MyFlow((state) {
          if (state.isFailed) {
            messageService.showSnackBar(
              (state.getErrorModel?.message == null &&
                      state.getErrorModel?.message.isNotEmpty == true)
                  ? state.getErrorModel!.message
                  : 'خطا در دریافت کارنامه',
            );
          }
          if (state.isSuccess && state.getData is NewWorkBookSerializer) {
            NewWorkBookSerializer workBookResponse = state.getData;
            if (workBookResponse.wordBookPdfLink != null) {
              messageService.showSnackBar('در حال دریافت کارنامه...');
              MyDownloader.openUrl(
                  link: workBookResponse.wordBookPdfLink!,
                  type: DownloadTaskTypes.url);
              _navigationService.pop();
            }
          }
        }),
        data: body);
  }

  @override
  String pageName() => 'download_workbook';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    //
  }
}
