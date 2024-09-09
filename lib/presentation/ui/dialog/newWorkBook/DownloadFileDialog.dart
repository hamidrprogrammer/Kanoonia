import 'package:flutter/material.dart';
import 'package:kanooniha/data/body/workBook/newWorkBook/new_workBook_body.dart';
import 'package:kanooniha/presentation/states/app_state.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:kanooniha/presentation/viewModels/workBook/newWorkBook/DownloadWorkBookViewModel.dart';

class DownloadFileDialog extends StatefulWidget {
  const DownloadFileDialog({Key? key, required this.body}) : super(key: key);
  final NewWorkBookBody body;

  @override
  State<DownloadFileDialog> createState() => _DownloadFileDialogState();
}

class _DownloadFileDialogState extends State<DownloadFileDialog> {
  late DownloadWorkBookViewModel viewModel;


  @override
  void initState() {
    viewModel = DownloadWorkBookViewModel(AppState.idle);
    viewModel.getWorkBook(widget.body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)),
      insetPadding: 16.dpe,
      alignment: Alignment.center,
      child: CubitProvider(
        create: (context) => viewModel,
        builder: (bloc, state) {
          return Container(
            decoration: BoxDecoration(borderRadius: 16.bRadius),
            child: Padding(
              padding: 16.dpe,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyLoader(radius: 20,color: Colors.blue),
                  8.dph,
                  const Expanded(child: Text('درحال دریافت اطلاعات'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
