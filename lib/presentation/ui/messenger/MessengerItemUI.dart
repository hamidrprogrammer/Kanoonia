import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../uiModel/messenger/MessengerUIModel.dart';

class MessengerItemUI extends StatelessWidget {
  const MessengerItemUI({
    Key? key,
    required this.model,
    required this.onClick,
  }) : super(key: key);
  final MessengerUIModel model;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: WidgetSize.pagePaddingSize),
      decoration: BoxDecoration(
          border: Border.all(
              color: model.read ? Colors.green.shade200 : Colors.red.shade200,
              width: 3),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      child: InkWell(
        onTap: onClick,
        borderRadius: 8.bRadius,
        child: Column(
          children: [
            const MySpacer(
              size: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: context.theme.primaryColor.withAlpha(50),
                              width: 2),
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(model.icon),
                      ),
                    ),
                    const SizedBox(width: 30, child: Divider()),
                    Text(model.from,
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontSize: 10, color: model.color))
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        model.title,
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const MySpacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          model.description,
                          style: context.textTheme.bodySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: onClick,
                        label: const Text('مشاهده بیشتر'),
                        icon: const Icon(CupertinoIcons.left_chevron),
                      ),
                      if (model.link.isBlank == false)
                        const Icon(Icons.attach_file_sharp, color: Colors.grey)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model.date,
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontSize: 10)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
