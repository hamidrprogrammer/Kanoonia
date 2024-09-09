import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/ui/poll/polls_item_ui.dart';
import 'package:kanooniha/presentation/viewModels/poll/polls_viewModel.dart';

class PollsUi extends StatefulWidget {
  const PollsUi({super.key});

  @override
  State<PollsUi> createState() => _PollsUiState();
}

class _PollsUiState extends State<PollsUi> {
  int? selectedOption;
  List<int>? selectedOptions;
  String? answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرسنجی'),
      ),
      body: CubitProvider(
        create: (context) => PollsViewModel(AppState.idle),
        builder: (bloc, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (bloc.pollsResponse?.title != null)
                Padding(
                  padding: 8.dpe,
                  child: Text(
                    bloc.pollsResponse?.title ?? '',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (bloc.pollsResponse?.description != null)
                Padding(
                  padding: 8.dpe,
                  child: Text(
                    bloc.pollsResponse?.description ?? '',
                    style:
                        context.textTheme.displaySmall?.copyWith(fontSize: 12),
                  ),
                ),
              Expanded(
                child: PageView(
              physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: bloc.controller,
                  children: bloc.pollsResponse?.polls?.map((poll) {
                        return PollsItemUI(
                          poll: poll,
                            type: bloc.pollsResponse!.type.getType,
                          index:
                              (bloc.pollsResponse?.polls?.indexOf(poll) ?? 0) +
                                  1,
                          onChangeIndex: (index) {
                            selectedOption = ((index ?? 0) + 1);
                          },
                          onChangeAnswer: (text) {
                            answer = text;
                          },
                          onChangeOptions: (options) {
                            selectedOptions = options;
                          },
                        );
                      }).toList() ??
                      [],
                  onPageChanged: (value) {
                    selectedOption = null;
                    answer = null;
                    selectedOptions = null;
                    bloc.index = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (bloc.pollsResponse != null) {
                      switch(bloc.pollsResponse!.type.getType){
                        case PollType.textField:
                          if (answer == null) {
                            bloc.messageService
                                .showSnackBar('متن توضیح را وارد کنید.');
                            return;
                          }
                          if (answer!.length < 5) {
                            bloc.messageService
                                .showSnackBar('متن توضیح کوتاه است.');
                            return;
                          }
                          break;
                        case PollType.multiSelect:
                          if (selectedOptions == null ) {
                            bloc.messageService
                                .showSnackBar('گزینه مورد نظر را انتخاب کنید');
                            return;
                          }
                          if (selectedOptions != null && selectedOptions!.isEmpty) {
                            bloc.messageService
                                .showSnackBar('گزینه مورد نظر را انتخاب کنید');
                            return;
                          }
                          break;
                        case PollType.singleSelect:
                          if (selectedOption == null) {
                            bloc.messageService
                                .showSnackBar('گزینه مورد نظر را انتخاب کنید');
                            return;
                          }
                          break;
                      }
                      var options = selectedOptions?.map((e) => e.toString()).toList();
                      bloc.setPoll(
                        bloc.pollsResponse!.polls![bloc.index],
                        answer,
                        selectedOption?.toString(),
                        options
                      );
                    }
                  },
                  child: state.isLoading
                      ? const MyLoader()
                      : const Text('ثبت نظر'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
