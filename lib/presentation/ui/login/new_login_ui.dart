import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/states/app_state.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/KanoonLogo.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:kanooniha/presentation/ui/main/Spacer.dart';
import 'package:kanooniha/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/uiModel/login/login_form_enum.dart';
import 'package:kanooniha/presentation/viewModels/login/login/newLoginformViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/validator/NationalCodeValidator.dart';

class NewLoginUi extends StatelessWidget {
  const NewLoginUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورود به حساب'),
      ),
      body: CubitProvider(
        create: (context) => NewLoginFormViewModel(AppState.idle),
        builder: (bloc, state) {
          return Padding(
            padding: 16.dpe,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const KanoonLogo(),
                    15.dpv,
                    TextFormFieldHelper(
                      label: 'کد ملی',
                      hint: 'کد ملی خود را وارد نمایید',
                      icon: CupertinoIcons.person_crop_square_fill,
                      validator: NationalCodeValidator(),
                      keyboardType: TextInputType.number,
                      onChangeValue: (value) {},
                      enable: false,
                      initValue: bloc.formModel?.nationalCode ?? '',
                      textAlign: TextAlign.left,
                      maxLength: 11,
                    ),
                    8.dpv,
                    bloc.formModel?.loginBy == LoginFormEnum.password
                        ? PasswordFieldHelper(
                            onChangeValue: bloc.onPasswordChange,
                          )
                        : TextFormFieldHelper(
                            label: 'شمارنده',
                            hint: 'شمارنده خود را وارد نمایید',
                            icon: CupertinoIcons.number,
                            keyboardType: TextInputType.number,
                            onChangeValue: bloc.onCounterChange,
                            maxLength: 9,
                            textAlign: TextAlign.left,
                          ),
                    16.dpv,
                    ElevatedButton(
                      onPressed: bloc.submitLogin,
                      child: state.isLoading
                          ? const MyLoader()
                          : const Text('ورود'),
                    ),
                    8.dpv,
                    if (bloc.formModel?.mobile == true)
                      TextButton(
                        onPressed: bloc.sendCode,
                        child: const Text("رمز خود را فراموش کرده اید؟"),
                      ),
                    const MySpacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrWidget extends StatelessWidget {
  const OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),
        4.dph,
        const Text('یا',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
        4.dph,
        const Expanded(child: Divider())
      ],
    );
  }
}
