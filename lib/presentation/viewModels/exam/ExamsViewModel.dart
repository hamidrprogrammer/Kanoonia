import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/core/Notification/MyNotificationListener.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/serializer/workBook/WorkBookInNavigationResponse.dart';
import 'package:kanooniha/domain/useCase/article/articles_UseCase.dart';
import 'package:kanooniha/domain/useCase/newMessage/messagesListUseCase.dart';
import 'package:kanooniha/domain/useCase/user/login/getUserInfoUseCase.dart';
import 'package:kanooniha/domain/useCase/workBook/dateValueWorkBookList/dateValueWorkBookList.dart';
import 'package:kanooniha/domain/useCase/workBook/lastExam/dateValueLastUseCase.dart';
import 'package:kanooniha/domain/useCase/workBook/nextExam/dateValueNextUseCase.dart';
import 'package:kanooniha/presentation/uiModel/messenger/MessengerUIModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../common/user/UserSessionConst.dart';
import '../../../core/Notification/MyNotification.dart';
import '../../../domain/useCase/exam/NextExamInfoUseCase.dart';
import '../../uiModel/profile/UserModel.dart';

class ExamsViewModel extends BaseViewModel implements MyNotificationListener {
  final MyNotification _notification = GetIt.I.get<MyNotification>();

  AppState pastExamState = AppState.idle;
  AppState messagesState = AppState.idle;
  AppState workBookData = AppState.idle;
  AppState currentExamState = AppState.idle;
  AppState newsState = AppState.idle;
  AppState userState = AppState.idle;
  String kindId = '';

  ExamsViewModel.initForPastExams(super.initialState) {
    getKindIdFromExtra();
    getPastExamExamInfo();
    logEvent();
  }

  ExamsViewModel(super.initialState) {
    getWorkBookData();
    logEvent();
    Logger.d('class name is ${toString()}');
    _notification.subscribeListener(this);
  }

  final _navigationService = GetIt.I.get<NavigationServiceImpl>();

  final _nextExamUseCase = NextExamUseCase();

  void getPastExamExamInfo() {
    DateValueWorkBookListUseCase().invoke(flow: MyFlow((appState) {
      pastExamState = appState;
      refreshStates();
    }));
  }

  void getWorkBookData() {
    DateValueLastUseCase().invoke(flow: MyFlow((appState) {
      workBookData = appState;
      refreshStates();
      if (appState.isSuccess || appState.isFailed) {
        getNextUserExamInfo();
      }
    }));
  }

  void fetchMessagesList({bool withState = true}) {
    MessagesListUseCase().invoke(flow: MyFlow((appState) {
      messagesState = appState;
      refreshStates();
      if (appState.isSuccess || appState.isFailed) {
        getMessages();
      }
    }));
  }

  void getMessages() {
    ArticlesUseCase().invoke(flow: MyFlow((appState) {
      newsState = appState;
      refreshStates();
    }));
  }

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

  void refreshStates() => updateScreen(time: DateTime.now().second.toDouble());

  void getNextUserExamInfo() {
    DateValueNextUseCase().invoke(flow: MyFlow((state) {
      currentExamState = state;
      refreshStates();
      if (state.isSuccess || state.isFailed) {
        fetchMessagesList();
      }
    }));
  }

  Function() navigateMessagesPage() {
    return () async {
      await _navigationService.navigateTo(AppRoutes.messengerPage);
      getNextUserExamInfo();
    };
  }

  Function() navigateToAddTargetPage() {
    return () async {
      ;
    };
  }

  @override
  void onReceiveData(data) {
    Logger.d('got new data is $data');
    // getNextUserExamInfo();
  }

  @override
  String tag() {
    return 'ExamsViewModel';
  }

  void getKindIdFromExtra() {
    if (_navigationService.getArgs() != null &&
        _navigationService.getArgs() is String) {
      kindId = _navigationService.getArgs();
    } else {
      _navigationService.pop();
    }
  }

  Future<dynamic>? navigate(MessengerUIModel model) {
    return _navigationService.navigateTo(AppRoutes.messengerDetailPage, model);
  }

  @override
  String pageName() => 'exams_page';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  void fetchUserData() {
    GetUserInfoUseCase().invoke(flow: MyFlow((appState) {
      userState = appState;
      refreshStates();
    }));
  }

  @override
  onReloadClick() {
    getWorkBookData();
  }
}
