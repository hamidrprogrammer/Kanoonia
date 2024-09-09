import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/validator/NationalCodeValidator.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/KanoonLogo.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/main/Spacer.dart';
import 'package:kanooniha/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/viewModels/login/login/new_login_viewModel.dart';

class InputNationalCodeUi extends StatelessWidget {
  const InputNationalCodeUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => NewLoginViewModel(AppState.idle),
      builder: (bloc, state) {
        return Form(
          key: bloc.formKey,
          child: Padding(
            padding: 16.dpe,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KanoonLogo(),
                      const MySpacer(),
                      TextFormFieldHelper(
                        label: 'کد ملی',
                        hint: 'کد ملی خود را وارد نمایید',
                        icon: CupertinoIcons.person_crop_square_fill,
                        validator: NationalCodeValidator(),
                        keyboardType: TextInputType.number,
                        onChangeValue: bloc.onChangeNationalCode,
                        textAlign: TextAlign.left,
                      ),
                      8.dpv,
                      ElevatedButton(
                        onPressed: bloc.submitCode,
                        child:
                            state.isLoading ? const MyLoader() : const Text('ورود'),
                      ),
                      16.dpv
                    ],),
              ),
            ),
          ),
        );
      },
    );
  }
}
