import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../data/body/gift/GetPopupMessagesResponse.dart';
import '../../../domain/useCase/home/StartupTaskUseCase.dart';
import '../../viewModels/login/GetPopupMessagesViewModel.dart';

class GiftMessageDialogUI extends StatelessWidget {
  const GiftMessageDialogUI({Key? key, required this.message})
      : super(key: key);
  final PopupMessage message;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetPopupMessagesViewModel(AppState.idle),
      builder: (bloc, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Padding(
              padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                    child: Text(
                      message.title ?? '',
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  const MySpacer(size: 20),
                  Text(
                    message.description ?? '',
                    style: context.textTheme.bodySmall,
                  ),
                  const MySpacer(size: 20),
                  ElevatedButton(
                      onPressed: () {
                        bloc.setLog(message.id?.toInt() ?? 0);
                      },
                      child: state.isLoading
                          ? const MyLoader()
                          : const Text('ورود به برنامه'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void checkStarUpData() {
    StartupTaskUseCase.invoke();
  }

  Future<bool> _launchUrl(String link) async {
    return launchUrl(Uri.parse(link));
  }
}
