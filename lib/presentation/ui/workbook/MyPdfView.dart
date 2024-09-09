import 'package:flutter/material.dart';
import 'package:kanooniha/core/GetExtensions.dart';
import 'package:kanooniha/core/Logger.dart';

class MyPdfView extends StatelessWidget {
  const MyPdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشاهده کارنامه'),
      ),
      // body: SfPdfViewer.network(
      //   getArgs(),
      //   enableDoubleTapZooming: true,
      //   onDocumentLoaded: (details) {
      //     Logger.d(details.document.documentInformation.title);
      //   },
      //   headers: const {
      //     'Access-Control-Allow-Origin': '*',
      //     'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,PATCH,OPTIONS',
      //   },
      // ),
    );
  }

  String getArgs() {
    return GetExtensions.getArgs<String>() ?? '';
  }
}
