import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/viewModels/call/calling_vm.dart';

class CallingUi extends StatefulWidget {
  const CallingUi({Key? key}) : super(key: key);

  @override
  State<CallingUi> createState() => CallingPageUIState();
}

class CallingPageUIState extends State<CallingUi> with WidgetsBindingObserver {
  static const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

  @override
  void initState() {
    super.initState();

    // initializeService();
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CallingViewModel(AppState.idle),
      builder: (bloc, state) {
        return Padding(
          padding: 32.dpe,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              const Icon(Icons.vibration, color: Colors.blue, size: 100.0),
              12.dpv,
              Text(
                bloc.user?.userName ?? '',
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              5.dpv,
              Text(
                "${bloc.user?.userName ?? ''} is calling",
                style: context.textTheme.displaySmall?.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const CircleBorder(),
                    ),
                    child: Padding(
                      padding: 8.dpe,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    onPressed: () async {
                      bloc.accept();
                      try {
                        await platform.invokeMethod('sendMessage', {
                          "methodName": "CallAnswer",
                          "message": bloc.user?.userId
                        });
                      } catch (e) {
                        print("Failed to send message: '$e'.");
                      }
                    },
                  ),
                  32.dph,
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                    ),
                    child: Padding(
                      padding: 8.dpe,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await platform.invokeMethod('sendMessage', {
                          "methodName": "CallAnswerEnd",
                          "message": bloc.user?.userId
                        });
                        bloc.decline(bloc.user?.userId);
                      } catch (e) {
                        print("Failed to send message: '$e'.");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
