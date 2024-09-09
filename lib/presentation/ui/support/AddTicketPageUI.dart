import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/support/support_kind_item.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../../domain/validator/support/AddTicketDescriptionValidation.dart';
import '../../viewModels/support/AddTicketViewModel.dart';
import '../exam/AddTargetPageUI.dart';
import '../main/ConditionalUI.dart';
import '../main/MyLoader.dart';
import '../main/TextFormFieldHelper.dart';

class AddTicketPageUI extends StatelessWidget {
  const AddTicketPageUI({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('درخواست پشتیبانی'),
        leading: const CustomLeading(),
      ),
      body: CubitProvider(
        create: (context) => AddTicketViewModel(AppState.idle),
        builder: (bloc, state) {
          return Padding(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Form(
              key: bloc.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const MySpacer(size: 20),
                    const Text(
                        'در این قسمت میتوانید مشکلات خود را با پشتیبانی مطرح نمایید و سپس در بخش پیام ها پاسخ را دریافت کنید'),
                    const MySpacer(size: 30),
                    TicketKindsPickerFormField(
                      state: bloc.kindsState,
                      onValueChange: bloc.onKindsChanged.call(),
                      onReloadClick: bloc.onReloadClick,
                    ),
                    const MySpacer(size: 20),
                    // TextFormFieldHelper(
                    //   label: 'عنوان مشکل',
                    //   hint: 'عنوان مشکل خود را وارد نمایید',
                    //   icon: CupertinoIcons.ant_circle,
                    //   validator: AddTicketTitleValidation(),
                    //   keyboardType: TextInputType.text,
                    //   onChangeValue: bloc.onTitleChange,
                    //   controller: bloc.titleController,
                    //   onTap: (){
                    //     if (bloc.titleController.selection ==
                    //         TextSelection.fromPosition(TextPosition(
                    //             offset: bloc.titleController.text.length - 1))) {
                    //       bloc.titleController.selection =
                    //           TextSelection.fromPosition(TextPosition(
                    //               offset: bloc.titleController.text.length));
                    //     }
                    //   },
                    // ),
                    // const MySpacer(size: 20),
                    SizedBox(
                      height: 200,
                      child: TextFormFieldHelper(
                        textInputAction: TextInputAction.newline,
                        controller: bloc.bodyController,
                        onTap: () {
                          if (bloc.bodyController.selection ==
                              TextSelection.fromPosition(TextPosition(
                                  offset:
                                      bloc.bodyController.text.length - 1))) {
                            bloc.bodyController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: bloc.bodyController.text.length));
                          }
                        },
                        label: 'توضیحات',
                        hint: 'توضیحات مشکل خود را وارد نمایید',
                        validator: AddTicketDescriptionValidation(),
                        keyboardType: TextInputType.multiline,
                        onChangeValue: bloc.onDescriptionChange,
                        expand: true,
                        maxLine: null,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const MySpacer(
                      size: 30,
                    ),
                    ElevatedButton(
                      onPressed: bloc.onClick.call(),
                      child: bloc.uiState.isLoading
                          ? const MyLoader()
                          : const Text('ثبت مشکل'),
                    )
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

class TicketKindsPickerFormField extends StatelessWidget {
  final Function(int?) onValueChange;

  const TicketKindsPickerFormField(
      {Key? key, required this.state, required this.onValueChange, required this.onReloadClick})
      : super(key: key);

  final AppState state;
  final Function() onReloadClick;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<List<SupportKindItem>>(
      onReloadClick: onReloadClick,
      skeleton: const TimesSkeleton(),
      state: state,
      onSuccess: (testResponse) {
        return DropdownButtonFormField<int>(
          hint: const Text('نوع مشکل خود را انتخاب کنید'),
          onChanged: onValueChange,
          items: testResponse.map((e) {
            return DropdownMenuItem<int>(
              value: e.kindId,
              child: Text(e.title.toString()),
            );
          }).toList(),
        );
      },
    );
  }
}
