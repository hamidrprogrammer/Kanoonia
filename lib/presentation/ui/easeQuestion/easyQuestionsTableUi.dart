import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/uiModel/easyQuestion/EasyQuestionModel.dart';

class EasyQuestionsTableUi extends StatelessWidget {
  const EasyQuestionsTableUi({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<EasyQuestionModel> data;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: InteractiveViewer(
        maxScale: 3,
        minScale: .1,
        child: DataTable(
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(4.0), color: Colors.grey),
          columns: [
            myColumnWidget('تاریخ'),
            myColumnWidget('صحیح'),
            myColumnWidget('غلط'),
            myColumnWidget('نزده'),
          ],
          rows: data
              .map(
                (e) => DataRow(
                  cells: [
                    myCellWidget(e.testDate.toString()),
                    myCellWidget(e.trues.join(',').toString()),
                    myCellWidget(e.falses.join(',').toString()),
                    myCellWidget(e.notCompletes.join(',').toString()),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  DataCell myCellWidget(String data) => DataCell(Center(
          child: Text(
        data,
        textAlign: TextAlign.center,
        textScaleFactor: 1,
      )));

  DataColumn myColumnWidget(String name) => DataColumn(
          label: Expanded(
        child: Center(
          child: Text(name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1),
        ),
      ));
}
