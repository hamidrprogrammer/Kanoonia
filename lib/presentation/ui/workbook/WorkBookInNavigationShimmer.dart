import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

class WorkBookInNavigationShimmer extends StatelessWidget {
  const WorkBookInNavigationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0), color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        DataTable(
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(4.0), color: Colors.grey),
          columns: [
            DataColumn(
                label: Container(
              margin: const EdgeInsets.all(4.0),
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey),
            )),
            DataColumn(
                label: Container(
              margin: const EdgeInsets.all(4.0),
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey),
            )),
            DataColumn(
                label: Container(
              margin: const EdgeInsets.all(4.0),
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey),
            )),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
            ]),
            DataRow(cells: [
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
            ]),
            DataRow(cells: [
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
            ]),
            DataRow(cells: [
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
            ]),
            DataRow(cells: [
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
              DataCell(Container(
                margin: const EdgeInsets.all(4.0),
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey),
              )),
            ]),
          ],
        )
      ]),
    );
  }
}
