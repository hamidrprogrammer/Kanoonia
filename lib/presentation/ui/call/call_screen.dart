import 'package:core/ringtone/my_ringtone.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kanooniha/core/TimeFormatter.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/viewModels/call/call_vm.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});
  static const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

  @override
  Widget build(BuildContext context) {
    final MyRingTone _ringTone = GetIt.I.get();
    _ringTone.stop();
    return CubitProvider(
      create: (context) => CallViewModel(AppState.idle),
      builder: (bloc, state) {
        if (!bloc.uiState.isSuccess) {
          return const MyLoader();
        }
        return Padding(
          padding: 32.dpe,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.call, color: Colors.blue, size: 100.0),
              12.dpv,
              Text(
                bloc.user?.userName ?? '',
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              5.dpv,
              Text(
                bloc.tick.formatMMSS() ?? '',
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
                      backgroundColor: Colors.grey.shade300,
                      shape: const CircleBorder(),
                      minimumSize: Size(40, 40),
                    ),
                    onPressed: bloc.mute,
                    child: Padding(
                      padding: 8.dpe,
                      child: Icon(
                        bloc.isMute ? Icons.mic : Icons.mic_off_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  16.dph,
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                      minimumSize: Size(55, 55),
                    ),
                    onPressed: () async {
                      try {
                        await platform.invokeMethod('sendMessage', {
                          "methodName": "CallAnswerEnd",
                          "message": bloc.user?.userId
                        });
                        bloc.hangup(bloc.user?.userId);
                      } catch (e) {
                        print("Failed to send message: '$e'.");
                      }
                    },
                    child: Padding(
                      padding: 8.dpe,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  if (!kIsWeb) 16.dph,
                  if (!kIsWeb)
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: const CircleBorder(),
                        minimumSize: Size(40, 40),
                      ),
                      onPressed: bloc.changeSpeaker,
                      child: Padding(
                        padding: 8.dpe,
                        child: Icon(
                          bloc.isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
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
