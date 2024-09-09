import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:core/downloader/MyDownloader.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

import '../../../data/serializer/book/CreateEBookFactorResponse.dart';
import '../../../data/serializer/book/GetEBookListResponse.dart';
import '../../../domain/useCase/book/CreateEBookFactorUseCase.dart';
import '../../../domain/useCase/book/GetEBookListUseCase.dart';

class GetEBookListViewModel extends BaseViewModel {
  final _navigationService = GetIt.I.get<NavigationServiceImpl>();
  final _getEBookListUseCase = GetEBookListUseCase();
  final _createEBookFactorUseCase = CreateEBookFactorUseCase();
  AppState viewState = AppState.idle;
  Map<int, AppState> booksState = {};

  GetEBookListViewModel(super.initialState) {
    getEbooks();
  }

  void getEbooks() {
    _getEBookListUseCase.invoke(flow: MyFlow((appState) {
      if (appState.isSuccess && appState.getData is GetEBookListResponse) {
        GetEBookListResponse response = appState.getData;
        response.data?.eBookList?.forEach((element) {
          booksState.clear();
          booksState[element.bookId?.toInt() ?? 0] = AppState.idle;
        });
      }
      viewState = appState;
      refreshScreen();
    }));
  }

  Function() onPayOrReadClick(EBookList? item) {
    return () {
      if (item == null) return;
      if (getState(item.bookId?.toInt() ?? 0).isLoading) return;
      if (item.isOpen == false) {
        var id = item.bookId?.toInt();
        if (id != null) {
          _createEBookFactorUseCase.createLink(
              flow: MyFlow((state) {
                updateBookState(id, state);
                if (state.isSuccess &&
                    state.getData is CreateEBookFactorResponse) {
                  CreateEBookFactorResponse response = state.getData;
                  if (response.data?.bankUrl != null) {
                    MyDownloader.openUrl(
                        link: response.data!.bankUrl!,
                        type: DownloadTaskTypes.url);
                  }
                }
              }),
              BookId: id);
        }
      } else {
        // _navigationService.navigateTo(AppRoutes.myPdfViewer, item.filePath);
      }
    };
  }

  MapEntry<int, AppState> getMapState(int bookId) {
    return booksState.entries.firstWhere(
      (element) => element.key == bookId,
      orElse: () => MapEntry(0, AppState.idle),
    );
  }

  AppState getState(int bookId) {
    return getMapState(bookId).value;
  }

  void updateBookState(int bookId, AppState appState) {
    booksState[bookId] = appState;
    refreshScreen();
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  @override
  String pageName() => 'booksPage';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getEbooks();
  }
}
