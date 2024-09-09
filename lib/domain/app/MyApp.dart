
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/core/messagingService/MessagingService.dart';
import 'package:kanooniha/presentation/ui/home/HomePageUI.dart';

import '../../common/imports/appImports.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);
  @override
  State<MyApp> createState() => _AppState();
}

// ignore: unused_element
class _AppState extends State<MyApp> {
  // This widget is the root of your application.

  static const String routeHome = '/', routeNotification = '/notification-page';
  TransitionBuilder rootTransitionBuilder() =>
      (_, child) => Scaffold(body: child);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      darkTheme: AppTheme.myTheme(),
      getPages: AppRouteHelper.router,
      title: 'Kanooniha',
      theme: AppTheme.myTheme(),
      locale: AppDefaultLocale.getAppLocale,
      supportedLocales: AppDefaultLocale.supportedLocale,
      localizationsDelegates: AppDefaultLocale.localizationDelegate,
      localeResolutionCallback: (_, __) => AppDefaultLocale.getAppLocale,
      builder: rootTransitionBuilder(),
      scaffoldMessengerKey: GetIt.I.get<MessagingServiceImpl>().messageService,
    );
  }
}
