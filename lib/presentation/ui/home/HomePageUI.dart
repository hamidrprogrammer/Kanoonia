import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/presentation/ui/exam/ExamPageShimmer.dart';
import 'package:badges/badges.dart' as b;
import 'package:kanooniha/presentation/ui/home/user_appBar_ui.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';
import 'package:kanooniha/presentation/uiModel/home/HomeNavigationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModels/home/HomeViewModel.dart';
import 'HomeNavigationUI.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> with WidgetsBindingObserver {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = HomeViewModel(AppState.idle);
    super.initState();

    // initializeService();
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    homeViewModel.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => homeViewModel,
      builder: (bloc, state) {
        return ConditionalUI(
          onReloadClick: bloc.onReloadClick,
          skeleton: const ExamPageShimmer(),
          state: bloc.menuState,
          onSuccess: (data) {
            return Scaffold(
              appBar: AppBar(
                centerTitle:
                    bloc.currentIndex.value() == HomeNavigationEnum.exam
                        ? false
                        : true,
                title: bloc.currentIndex.value() == HomeNavigationEnum.exam
                    ? UserAppBarUi(
                        title: bloc.currentIndex.name,
                      )
                    : Text(bloc.currentIndex.getName),
                actions: bloc.appBarMenu.map((hbnI) {
                  return InkWell(
                    onTap: () {
                      bloc.onIndexChange().call(hbnI);
                    },
                    child: Padding(
                      padding: 8.dpeh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          b.Badge(
                            badgeContent: Text(
                              hbnI.getBadge,
                              style: const TextStyle(color: Colors.white),
                            ),
                            showBadge: (hbnI.getBadge.isBlank == false),
                            child: Icon(
                              hbnI.getIcon,
                              color: bloc.currentIndex == hbnI
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              body: bloc.getPage(),
              bottomNavigationBar: HomeNavigationUI(
                menu: bloc.homeMenu,
                currentIndex: bloc.currentIndex,
                onHomeIndexChange: bloc.onIndexChange.call(),
              ),
            );
          },
        );
      },
    );
  }
}
