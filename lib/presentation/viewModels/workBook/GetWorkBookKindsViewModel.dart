//this tool use in web

import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:core/downloader/MyDownloader.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/data/serializer/workBook/kinds/workBookKindItem.dart';
import 'package:kanooniha/data/serializer/workBook/newWorkBook/NewWorkBookSerializer.dart';
import 'package:kanooniha/domain/useCase/workBook/kind/WorkBookKindsUseCase.dart';
import 'package:kanooniha/domain/useCase/workBook/newWorkBook/newWorkBookUseCase.dart';

import '../../../common/appCommons/appRoutes.dart';

class GetWorkBookKindsViewModel extends BaseViewModel {
  Map<String, AppState> kindsState = {};
  final _navigationService = GetIt.I.get<NavigationServiceImpl>();
  final _messageService = GetIt.I.get<MessagingServiceImpl>();

  AppState workBookState = AppState.idle;

  GetWorkBookKindsViewModel(super.initialState) {
    getGetWorkBookKinds();
    logEvent();
  }

  void getGetWorkBookKinds() {
    WorkBookKindsUseCase().invoke(flow: MyFlow((newState) {
      if (newState.isSuccess && newState.getData is List<WorkBookKindItem>) {
        List<WorkBookKindItem> response = newState.getData;
        for (var element in response) {
          kindsState.clear();
          kindsState[element.kind] = AppState.idle;
        }
      }
      updateWorkBookState(newState);
    }));
  }

  void getWorkBook(String kindId, String? testDate) {
    if (getState(kindId).isLoading) return;
    NewWorkBookBody body =
        NewWorkBookBody(kind: kindId.toString(), dateValue: testDate);
    NewWorkBookUseCase().invoke(
        flow: MyFlow((state) {
          updateKindState(kindId, state);
          if (state.isFailed) {
            _messageService.showSnackBar(state.getErrorModel?.message ?? 'خطا در دریافت کارنامه');
          }
          if (state.isSuccess && state.getData is NewWorkBookSerializer) {
            NewWorkBookSerializer workBookResponse = state.getData;
            if (workBookResponse.wordBookPdfLink != null) {
              _messageService.showSnackBar('در حال دریافت کارنامه...');
              MyDownloader.openUrl(link: workBookResponse.wordBookPdfLink!);
              // if (kIsWeb) {
              //   _messageService.showSnackBar('در حال دریافت کارنامه...');
              //   MyDownloader.openUrl(link: workBookResponse.wordBookPdfLink!);
              // } else {
              //   _navigationService.navigateTo(
              //     AppRoutes.myPdfViewer,
              //     workBookResponse.wordBookPdfLink,
              //   );
              // }
            }
          }
        }),
        data: body);
  }

  onOpenLickClick(String url) {
    MyDownloader.openUrl(link: url, type: DownloadTaskTypes.url);
  }

  void updateWorkBookState(AppState newState) {
    workBookState = newState;
    refreshScreen();
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  MapEntry<String, AppState> getMapState(String kindId) {
    return kindsState.entries.firstWhere(
      (element) => element.key == kindId,
      orElse: () => MapEntry('', AppState.idle),
    );
  }

  void onDownloadClick({required String kindId, int? testDate}) {
    getWorkBook(kindId, testDate?.toString());
  }

  AppState getState(String kindId) {
    return getMapState(kindId).value;
  }

  void updateKindState(String kindId, AppState appState) {
    kindsState[kindId] = appState;
    refreshScreen();
  }

  void navigateToPastDates(String kindId) {
    _navigationService.navigateTo(AppRoutes.pastExamsPage, kindId);
  }

  void navigateToRoute(String kind) {
    _navigationService.navigateTo(kind);
  }

  @override
  String pageName() => 'workBookKinds';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getGetWorkBookKinds();
  }
}
