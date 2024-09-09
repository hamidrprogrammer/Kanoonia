import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/support/support_item.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../viewModels/support/GetPastRequestViewModel.dart';
import '../main/ConditionalUI.dart';
import '../main/CubitProvider.dart';
import '../main/EmptyPageUI.dart';
import 'MessagesShimmer.dart';

class MessagesPageUI extends StatelessWidget {
  const MessagesPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetPastRequestViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('پیام ها'),
            leading: const CustomLeading(),
          ),
          body: ConditionalUI<List<SupportItem>>(
            onReloadClick: bloc.onReloadClick,
            skeleton: const MessagesShimmer(),
            state: state,
            onSuccess: (data) {
              if (data.isEmpty == true) {
                return const EmptyPageUI();
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  itemBuilder: (context, index) {
                    var item = data.elementAt(index);
                    return MessageItemUI(item: item);
                  },
                  separatorBuilder: (context, index) => const MySpacer(
                    size: 20,
                  ),
                  itemCount: data.length,
                );
              }
            },
          ),
        );
      },
    );
  }
}

class MessageItemUI extends StatelessWidget {
  const MessageItemUI({
    super.key,
    required this.item,
  });

  final SupportItem item;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      borderColor:
          item.hasAnswer == true ? Colors.green.shade200 : Colors.red.shade200,
      borderWidth: 3,
      elevation: 0.0,
      color: Colors.white,
      nip: BubbleNip.rightTop,
      padding: const BubbleEdges.all(WidgetSize.pagePaddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(WidgetSize.basePaddingSize),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'شما',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: context.theme.primaryColor),
                ),
                const MySpacer(),
                // Text(
                //   item.requestTitle ?? '',
                //   style: context.textTheme.bodySmall
                //       ?.copyWith(fontWeight: FontWeight.bold),
                // ),
                // const MySpacer(),
                Text(
                  item.body,
                  style: context.textTheme.bodySmall,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                MySpacer(size: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item.dateInsert?.toPersianDateStr() ?? '',
                      style: context.textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          ),
          if (item.hasAnswer == true) const MySpacer(),
          if (item.hasAnswer == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item.answerText ?? ''),
            ),
          if (item.hasAnswer == true) const MySpacer(),
          if (item.hasAnswer == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(item.dateAnswer?.toPerDate ?? '')],
            )
        ],
      ),
    );
  }
}
