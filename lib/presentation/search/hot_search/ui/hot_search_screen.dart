import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/components/image_network_builder.dart';
import 'package:muaho/presentation/order/order_screen.dart';
import 'package:muaho/presentation/search/hot_search/bloc/hot_search_bloc.dart';
import 'package:muaho/presentation/search/search_shop/ui/search_shop.dart';

import '../../../../main.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HotSearchBloc>(
      create: (_) => getIt()..add(HotSearchRequestEvent()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: _appBar(context),
            ),
            body: BlocBuilder<HotSearchBloc, HotSearchState>(
              builder: (ctx, state) {
                if (state is HotSearchLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HotSearchSuccessState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Text(
                            LocaleKeys.hotSearch_hotItems,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 32,
                          child: ListView.separated(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.result.listHotKeywords.length,
                            itemBuilder: (ctx, index) {
                              return _itemHotKeyword(
                                  state.result.listHotKeywords[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 5,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Text(
                            LocaleKeys.hotSearch_hotShop,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.73,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20),
                          shrinkWrap: true,
                          itemCount: state.result.listHotShop.length,
                          itemBuilder: (ctx, index) {
                            return _itemHotShop(
                              state.result.listHotShop[index],
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(LocaleKeys.hotSearch_errorMsg),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemHotKeyword(HotKeyword hotKeyword) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, SearchShopScreen.routeName,
            arguments: SearchShopArgument(keyword: hotKeyword.name));
      },
      child: Text(
        hotKeyword.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      style: MyTheme.buttonStyleDisableLessImportant,
    );
  }

  Widget _itemHotShop(HotShop hotShop) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderScreen.routeName,
            arguments: ShopArgument(shopId: hotShop.id));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ImageNetworkBuilder(
                  size: Size.square(150),
                  imgUrl: hotShop.thumbUrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  hotShop.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Text(
                  hotShop.address,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _appBar(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
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
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: _controller,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              Navigator.pushNamed(context, SearchShopScreen.routeName,
                                  arguments: SearchShopArgument(
                                      keyword: _controller.text));
                            }
                          },
                        ),
                        hintText: LocaleKeys.hotSearch_searchHint.translate(),
                        hintStyle: TextStyle(),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
