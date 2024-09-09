import 'package:get/get.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/presentation/ui/call/call_screen.dart';
import 'package:kanooniha/presentation/ui/call/calling_ui.dart';
import 'package:kanooniha/presentation/ui/easeQuestion/EasyQuestionUi.dart';
import 'package:kanooniha/presentation/ui/exam/PastExamDetailUI.dart';
import 'package:kanooniha/presentation/ui/exam/TargetPageUi.dart';
import 'package:kanooniha/presentation/ui/home/HomePageUI.dart';
import 'package:kanooniha/presentation/ui/inbox/InboxPageUI.dart';
import 'package:kanooniha/presentation/ui/login/VerificationPageUI.dart';
import 'package:kanooniha/presentation/ui/login/input_national_code_ui.dart';
import 'package:kanooniha/presentation/ui/login/new_login_ui.dart';
import 'package:kanooniha/presentation/ui/splash/SplashScreen.dart';
import 'package:kanooniha/presentation/ui/workbook/MyPdfView.dart';
import 'package:kanooniha/presentation/ui/workbook/WorkBookInNavigationUi.dart';

import '../../presentation/ui/book/BooksPageUI.dart';
import '../../presentation/ui/exam/AddTargetPageUI.dart';
import '../../presentation/ui/exam/PastExamPageUI.dart';
import '../../presentation/ui/messenger/MessengerDetailPageUI.dart';
import '../../presentation/ui/messenger/MessengerPageUI.dart';
import '../../presentation/ui/poll/polls_ui.dart';
import '../../presentation/ui/support/AddTicketPageUI.dart';
import '../../presentation/ui/support/MessagesPageUI.dart';
import '../../presentation/ui/support/SupportPageUI.dart';

class AppRouteHelper {
  static List<GetPage> router = [
    GetPage(name: AppRoutes.root, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomePageUI()),
    GetPage(name: AppRoutes.login, page: () => const InputNationalCodeUi()),
    GetPage(name: AppRoutes.loginForm, page: () => const NewLoginUi()),
    GetPage(
        name: AppRoutes.verification, page: () => const VerificationPageUI()),
    GetPage(
      name: AppRoutes.addTestTargetPage,
      page: () => const AddTargetPageUI(),
    ),
    GetPage(
      name: AppRoutes.testDetailPage,
      page: () => const PastExamDetailUI(),
    ),
    GetPage(
      name: AppRoutes.myPdfViewer,
      page: () => const MyPdfView(),
    ),
    GetPage(
      name: AppRoutes.appSupport,
      page: () => const SupportPageUI(),
    ),
    GetPage(
      name: AppRoutes.supportMessages,
      page: () => const MessagesPageUI(),
    ),
    GetPage(
      name: AppRoutes.addTicketPage,
      page: () => const AddTicketPageUI(),
    ),
    GetPage(
      name: AppRoutes.messengerPage,
      page: () => const MessengerPageUI(),
    ),
    GetPage(
      name: AppRoutes.booksPage,
      page: () => const BooksPageUI(),
    ),
    GetPage(
      name: AppRoutes.pastExamsPage,
      page: () => const PastExamPageUI(),
    ),
    GetPage(
      name: AppRoutes.messengerDetailPage,
      page: () => const MessengerDetailPageUI(),
    ),
    GetPage(
      name: AppRoutes.news,
      page: () => const InboxPageUI(),
    ),
    GetPage(
      name: AppRoutes.target,
      page: () => const TargetPageUi(),
    ),
    GetPage(
      name: AppRoutes.workbookEasy,
      page: () => const EasyQuestionsUi(),
    ),
    GetPage(
      name: AppRoutes.workbookFirst,
      page: () => const WorkBookInNavigationUi(),
    ),
    GetPage(
      name: AppRoutes.polls,
      page: () => const PollsUi(),
    ),
    GetPage(
      name: AppRoutes.calling,
      page: () => const CallingUi(),
    ),
    GetPage(
      name: AppRoutes.call,
      page: () => const CallScreen(),
    ),
  ];
}
