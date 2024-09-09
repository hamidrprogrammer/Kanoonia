import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';

class DropDownFormField<T> extends StatelessWidget {
  const DropDownFormField(
      {Key? key,
      required this.selectedItem,
      required this.items,
      required this.name,
      required this.onValueChange})
      : super(key: key);
  final T? selectedItem;
  final List<T> items;
  final String name;
  final Function(T?) onValueChange;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        menuMaxHeight: 200,
        isDense: false,
        isExpanded: false,
        borderRadius: const BorderRadius.all(
            Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          name,
          style: context.textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: .9,
        ),
        onChanged: onValueChange,
        items: List.generate(items.length, (index) {
          var item = items.elementAt(index);
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: .9,
            ),
          );
        }),
      ),
    );
  }
}
