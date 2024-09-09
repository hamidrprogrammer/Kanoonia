import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/CubitProvider.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../data/serializer/book/GetEBookListResponse.dart';
import '../../../domain/imageLoader/ImageLoader.dart';
import '../../viewModels/book/GetEBookListViewModel.dart';
import '../main/ConditionalUI.dart';
import '../main/EmptyPageUI.dart';
import 'BooksShimmer.dart';

class BooksPageUI extends StatelessWidget {
  const BooksPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کتاب'),
      ),
      body: CubitProvider(
        create: (context) => GetEBookListViewModel(AppState.idle),
        builder: (bloc, state) {
          return ConditionalUI<GetEBookListResponse>(
            onReloadClick: bloc.onReloadClick,
            skeleton: const BooksShimmer(),
            state: bloc.viewState,
            onSuccess: (data) {
              if (data.data?.eBookList?.isEmpty == true) {
                return const EmptyPageUI();
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                  itemCount: data.data?.eBookList?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (context, index) {
                    var item = data.data?.eBookList?.elementAt(index);
                    return BookItemUI(
                      item: item,
                      state: bloc.getState(item?.bookId?.toInt() ?? 0),
                      onClick: bloc.onPayOrReadClick.call(item),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

class BookItemUI extends StatelessWidget {
  const BookItemUI({
    super.key,
    required this.item,
    required this.state,
    required this.onClick,
  });

  final EBookList? item;
  final AppState state;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(WidgetSize.basePaddingSize),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(WidgetSize.baseRadiusSize),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(WidgetSize.baseRadiusSize),
                child: ImageLoader(
                  url: item?.bookImagePath ?? '',
                  fitModel: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              item?.bookName ?? '',
              style: context.textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const MySpacer(),
            Text(
              '${item?.amount?.toString().seRagham()} تومان',
              style: context.textTheme.bodySmall,
            ),
            const Divider(),
            TextButton.icon(
              onPressed: onClick,
              icon: const Icon(CupertinoIcons.shopping_cart),
              label: state.isLoading
                  ? MyLoader(color: context.theme.primaryColor)
                  : Text(item?.isOpen == true ? 'مشاهده' : 'خرید کتاب'),
            )
          ],
        ),
      ),
    );
  }
}
