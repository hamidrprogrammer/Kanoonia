import 'package:flutter/material.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/viewModels/login/verification/NewVerificationViewModel.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../domain/validator/login/VerificationValidator.dart';
import '../main/InnerRowWidget.dart';
import '../main/KanoonLogo.dart';
import '../main/MyLoader.dart';
import '../main/TextFormFieldHelper.dart';

class VerificationPageUI extends StatelessWidget {
  const VerificationPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('ورود به حساب'),
    ),
      body: CubitProvider(
        create: (context) => NewVerificationViewModel(AppState.idle),
        builder: (bloc, state) {
          return Padding(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Form(
              key: bloc.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KanoonLogo(),
                      const MySpacer(),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormFieldHelper(
                          textAlign: TextAlign.center,
                          label: 'کد تایید',
                          hint: 'کد تایید را وارد نمایید',
                          icon: CupertinoIcons.lock,
                          validator: VerificationValidator(),
                          keyboardType: TextInputType.phone,
                          onChangeValue: bloc.onCodeChange,
                          maxLength: 6,
                        ),
                      ),
                      const MySpacer(),
                      InnerRowWidget(
                        alignment: MainAxisAlignment.center,
                        child: ElevatedButton.icon(
                          onPressed: bloc.submitCode,
                          icon: const Icon(CupertinoIcons.check_mark),
                          label: bloc.state.isLoading
                              ? const MyLoader()
                              : const Text('ورود'),
                        ),
                      ),
                      16.dpv
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
