import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/data/serializer/newMessages/messageItem.dart';
import 'package:kanooniha/presentation/ui/main/ConditionalUI.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';

import '../../../common/imports/WidgetImports.dart';
import '../../uiModel/messenger/MessengerUIModel.dart';
import '../../viewModels/messenger/FetchAllMessagesListViewModel.dart';
import '../inbox/InboxShimmer.dart';
import '../main/EmptyPageUI.dart';
import 'MessengerItemUI.dart';

class MessengerPageUI extends StatelessWidget {
  const MessengerPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('پیام ها'),
      // ),
      body: CubitProvider(
        create: (context) => FetchAllMessagesListViewModel(AppState.idle),
        builder: (bloc, state) {
          return WillPopScope(
            onWillPop: () async {
              Get.back(result: bloc.count);
              return true;
            },
            child: ConditionalUI<List<NewMessageItem>>(
              onReloadClick: bloc.onReloadClick,
              skeleton: const InboxShimmer(),
              state: state,
              onSuccess: (data) {
                return (data.isNotEmpty == true)
                    ? ListView.separated(
                        padding:
                            const EdgeInsets.all(WidgetSize.pagePaddingSize),
                        itemBuilder: (context, index) => MessengerItemUI(
                          model: data.elementAt(index).getMessengerUiModel(),
                          onClick: () async {
                            await bloc.navigate(
                                data.elementAt(index).getMessengerUiModel());
                            bloc.fetchMessagesList(withState: false);
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            const MySpacer(size: 16),
                        itemCount: data.length,
                      )
                    : const EmptyPageUI();
              },
            ),
          );
        },
      ),
    );
  }
}
