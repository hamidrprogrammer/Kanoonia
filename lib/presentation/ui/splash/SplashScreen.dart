import 'package:flutter/material.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../viewModels/splash/SplashScreenViewModel.dart';
import '../main/KanoonLogo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SplashScreenViewModel(AppState.idle),
      builder: (bloc, state) {
        return const Center(
          child: KanoonLogo(),
        );
      },
    );
  }
}
