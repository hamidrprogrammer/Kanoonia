import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/states/app_state.dart';
import 'package:kanooniha/presentation/ui/easeQuestion/easyQuestionsTableUi.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/DropDownFormField.dart';
import 'package:kanooniha/presentation/ui/main/EmptyPageUI.dart';
import 'package:kanooniha/presentation/ui/main/Spacer.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';
import 'package:kanooniha/presentation/uiModel/easyQuestion/EasyQuestionModel.dart';
import 'package:kanooniha/presentation/viewModels/easyQuestion/easyQuestionsViewModel.dart';

class EasyQuestionsUi extends StatelessWidget {
  const EasyQuestionsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوالات ساده'),
        leading: const CustomLeading(),
      ),
      body: CubitProvider(
        create: (context) => EasyQuestionsViewModel(AppState.idle),
        builder: (bloc, state) {
          return ConditionalUI<EasyQuestionUiModel>(
          onReloadClick: bloc.onReloadClick,
            state: bloc.uiState,
            onSuccess: (data) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropDownFormField<String>(
                        items: data.courses.toSet().toList(),
                        name: 'نام درس',
                        onValueChange: bloc.onCourseChange,
                        selectedItem: bloc.selectedCourse,
                      ),
                      // MySpacer(),
                      // DropDownFormField<String>(
                      //   items: bloc.selectedQuestion.data.map((e) => e.name).toList(),
                      //   name: 'درس',
                      //   onValueChange: bloc.onQuestionsChange,
                      //   selectedItem: bloc.selectedQuestion,
                      // ),
                      const MySpacer(),
                      bloc.currentModel.isNotEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child:
                                  EasyQuestionsTableUi(data: bloc.currentModel))
                          : const EmptyPageUI(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
