import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/models/search/search_shop/seach_shop.dart';
import 'package:muaho/presentation/search/search_shop/bloc/search_shop_bloc.dart';

class SearchShopScreen extends StatefulWidget {
  static const routeName = '/search_shop';
  const SearchShopScreen({Key? key}) : super(key: key);

  @override
  _SearchShopScreenState createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchArgument;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: _appBar(context),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: BlocProvider<SearchShopBloc>(
              create: (_) => SearchShopBloc()
                ..add(
                  SearchEvent(keyword: args.keyword),
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
          child: Text("Nothing here"),
        );
      } else {
        return _requestSearchShopSuccessBuilder(state, ctx);
      }
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }

  Container _appBar(BuildContext context) {
    // TextEditingController _controller = new TextEditingController();
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.navigate_before,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Chọn cửa hàng".toUpperCase(),
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  SliverAppBar(
  //           automaticallyImplyLeading: false,
  //           backgroundColor: Color(0x00FFFFF),
  //           floating: false,
  //           title: Padding(
  //             padding: const EdgeInsets.only(left: 8),
  //             child: Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text(
  //                 "Tất cả cửa hàng",
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .headline3!
  //                     .copyWith(fontSize: 20),
  //               ),
  //             ),
  //           ),
  //         ),

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
                      "Tất cả cửa hàng",
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
                              Text("Bộ Lọc",
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: FadeInImage.assetNetwork(
                  width: 130,
                  height: 100,
                  placeholder: 'assets/images/placeholder.png',
                  image: shop.thumbUrl,
                  fit: BoxFit.fill,
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
    );
  }
}

class SearchArgument {
  final String keyword;

  SearchArgument({required this.keyword});
}
