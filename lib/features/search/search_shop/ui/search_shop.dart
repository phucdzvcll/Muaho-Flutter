import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/components/app_bar_component.dart';
import 'package:muaho/features/components/image_network_builder.dart';
import 'package:muaho/features/order/presentation/order_screen.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';
import 'package:muaho/features/search/search_shop/bloc/search_shop_bloc.dart';
import 'package:muaho/generated/locale_keys.g.dart';

class SearchShopScreen extends StatefulWidget {
  static const routeName = '/search_shop';
  final SearchShopArgument args;

  const SearchShopScreen({Key? key, required this.args}) : super(key: key);

  @override
  _SearchShopScreenState createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBarComponent.titleOnly(
              title: LocaleKeys.searchShop_chooseShop.translate()),
          body: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: BlocProvider<SearchShopBloc>(
              create: (_) {
                var args = widget.args;
                if (args is SearchShopByKeyword) {
                  return inject()
                    ..add(
                      SearchByKeywordEvent(keyword: args.keyword),
                    );
                } else if (args is SearchShopByCategory) {
                  return inject()
                    ..add(
                      SearchByCategoryEvent(categoryID: args.categoryId),
                    );
                } else {
                  return inject();
                }
              },
              child: BlocBuilder<SearchShopBloc, SearchShopState>(
                builder: (ctx, state) {
                  return _handleRequestSearch(state, ctx);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleRequestSearch(SearchShopState state, BuildContext ctx) {
    if (state is SearchShopLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchShopSuccess) {
      return _requestSearchShopSuccessBuilder(state, ctx);
      // if (state.shops.isEmpty) {
      //   return Center(
      //     child: Text(LocaleKeys.searchShop_noDataMsg.translate()),
      //   );
      // } else {
      //
      // }
    } else {
      return Center(
        child: Text(LocaleKeys.searchShop_errorMsg.translate()),
      );
    }
  }

  Widget _requestSearchShopSuccessBuilder(
      SearchShopSuccess state, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state is SearchShopByCategorySuccess
                        ? state.category
                        : LocaleKeys.searchShop_allShop.translate(),
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: state.shops.isEmpty
                ? Center(
                    child: Text(LocaleKeys.searchShop_noDataMsg.translate()),
                  )
                : _buildListShop(state.shops),
          ),
        ],
      ),
    );
  }

  ListView _buildListShop(List<SearchShopByKeywordEntity> shops) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return _shopItems(shops[index]);
      },
      itemCount: shops.length,
      addAutomaticKeepAlives: true,
    );
  }

  Widget _shopItems(SearchShopByKeywordEntity shop) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderScreen.routeName,
            arguments: ShopArgument(shopId: shop.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: ImageNetworkBuilder(
                      imgUrl: shop.thumbUrl,
                      size: Size.square(130),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        shop.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RatingBar.builder(
                        initialRating: shop.star,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 12,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    Text(
                      shop.address,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

abstract class SearchShopArgument extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchShopByKeyword extends SearchShopArgument {
  final String keyword;

  SearchShopByKeyword({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}

class SearchShopByCategory extends SearchShopArgument {
  final int categoryId;

  SearchShopByCategory({
    required this.categoryId,
  });

  @override
  List<Object?> get props => [categoryId];
}
