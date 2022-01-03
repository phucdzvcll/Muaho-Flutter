import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/models/search/search_shop/seach_shop.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/components/app_bar_component.dart';
import 'package:muaho/presentation/components/image_network_builder.dart';
import 'package:muaho/presentation/order/order_screen.dart';
import 'package:muaho/presentation/search/search_shop/bloc/search_shop_bloc.dart';

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
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarComponent.titleOnly(title: LocaleKeys.searchShop_chooseShop.translate()),
          body: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: BlocProvider<SearchShopBloc>(
              create: (_) => getIt()
                ..add(
                  SearchEvent(keyword: widget.args.keyword),
                ),
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
      if (state.shops.isEmpty) {
        return Center(
          child: Text(LocaleKeys.searchShop_noDataMsg.translate()),
        );
      } else {
        return _requestSearchShopSuccessBuilder(state, ctx);
      }
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
                      LocaleKeys.searchShop_allShop.translate(),
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8, bottom: 16),
                      child: Container(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: ctx,
                                builder: (BuildContext ctx) {
                                  return Center(
                                    child: Container(
                                        width: 200,
                                        height: 200,
                                        color: Colors.white),
                                  );
                                });
                          },
                          style: MyTheme.buttonStyleDisableLessImportant
                              .copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.only(left: 16, right: 16),
                                  )),
                          child: Row(
                            children: [
                              Text(LocaleKeys.searchShop_filterButton.translate(),
                                  style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Icon(
                                  Icons.tune,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return _shopItems(state.shops[index]);
              },
              itemCount: state.shops.length,
              addAutomaticKeepAlives: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopItems(SearchShop shop) {
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
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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

class SearchShopArgument {
  final String keyword;

  SearchShopArgument({required this.keyword});
}
