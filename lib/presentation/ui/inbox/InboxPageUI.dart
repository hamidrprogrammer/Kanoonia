import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/article/ArticleItemSerializer.dart';
import 'package:kanooniha/domain/imageLoader/ImageLoader.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/custom_leasing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../viewModels/inbox/GetInboxMessagesViewModel.dart';
import '../main/EmptyPageUI.dart';
import 'InboxShimmer.dart';

class InboxPageUI extends StatelessWidget {
  const InboxPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اعلانات'),
        leading: const CustomLeading(),
      ),
      body: CubitProvider(
        create: (_) => GetInboxMessagesViewModel(AppState.idle),
        builder: (bloc, state) {
          return ConditionalUI<List<ArticleItemSerializer>>(
            onReloadClick: bloc.onReloadClick,
            skeleton: const InboxShimmer(),
            state: state,
            onSuccess: (data) {
              if (data.isEmpty == true) {
                return const EmptyPageUI();
              } else {
                return ListView.separated(
                    padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                    itemBuilder: (context, index) {
                      var item = data.elementAt(index);
                      return InboxMessageItemUI(item: item);
                    },
                    separatorBuilder: (context, index) => const MySpacer(),
                    itemCount: data.length);
              }
            },
          );
        },
      ),
    );
  }
}

class InboxMessageItemUI extends StatelessWidget {
  const InboxMessageItemUI({
    super.key,
    required this.item,
  });

  final ArticleItemSerializer? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _launchUrl(item?.url ?? '');
      },
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: SizedBox(
                width: 25,
                height: 25,
                child: ImageLoader(url: item?.pictureUrl ?? '')),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Text(item?.title ?? '')),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MySpacer(),
          const Divider(),
          const MySpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: TextButton.icon(
                  label: const Text('مشاهده'),
                  icon: const Icon(CupertinoIcons.arrow_left),
                  onPressed: () {
                    _launchUrl(item?.url ?? '');
                  },
                ),
              ),
            ],
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade400, width: 1.5),
      ),
      minVerticalPadding: 10,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
