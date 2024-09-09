import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/data/serializer/poll/polls_response.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';

import '../main/TextFormFieldHelper.dart';

class PollsItemUI extends StatefulWidget {
  PollsItemUI({
    super.key,
    required this.poll,
    required this.type,
    required this.index,
    required this.onChangeIndex,
    required this.onChangeAnswer,
    required this.onChangeOptions,
  });

  final Poll poll;
  final PollType type;
  final int index;
  final Function(int?) onChangeIndex;
  final Function(String?) onChangeAnswer;
  final Function(List<int>?) onChangeOptions;

  final TextEditingController bodyController = TextEditingController();

  @override
  State<PollsItemUI> createState() => _PollsItemUIState();
}

class _PollsItemUIState extends State<PollsItemUI> {
  int? selectedItem;
  List<int> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: 8.dpe,
          child: Text(
            '${widget.index}.${widget.poll.question ?? ''}',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (widget.type == PollType.textField)
          Container(
            margin: 16.dpe,
            height: 200,
            child: TextFormFieldHelper(
              controller: widget.bodyController,
              textInputAction: TextInputAction.newline,
              onTap: () {
                if (widget.bodyController.selection ==
                    TextSelection.fromPosition(TextPosition(
                        offset: widget.bodyController.text.length - 1))) {
                  widget.bodyController.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.bodyController.text.length));
                }
              },
              label: 'توضیحات',
              hint: 'توضیحات خود را وارد نمایید',
              keyboardType: TextInputType.multiline,
              onChangeValue: widget.onChangeAnswer,
              expand: true,
              maxLine: null,
              textAlign: TextAlign.start,
            ),
          ),
        if (widget.type == PollType.singleSelect)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.poll.options?.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index,
                  groupValue: selectedItem,
                  onChanged: (value) {
                    widget.onChangeIndex.call(value);
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  title: Text(widget.poll.options?[index] ?? ''),
                );
              },
            ),
          ),
        if (widget.type == PollType.multiSelect)
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.poll.options?.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: selectedItems.contains((index + 1)),
                  onChanged: (value) {
                    print('value os $index is $value');
                    if (value == true) {
                      selectedItems.add(index + 1);
                    } else {
                      selectedItems.remove(index + 1);
                    }
                    widget.onChangeOptions.call(selectedItems);
                    setState(() {});
                  },
                  title: Text(widget.poll.options?[index] ?? ''),
                );
              },
            ),
          ),
      ],
    );
  }
}

enum PollType { textField, multiSelect, singleSelect }

extension PollsTypeExtension on int? {
  PollType get getType {
    switch (this) {
      case 1:
        return PollType.singleSelect;
      case 2:
        return PollType.textField;
      case 3:
        return PollType.multiSelect;
      default:
        return PollType.singleSelect;
    }
  }
}
