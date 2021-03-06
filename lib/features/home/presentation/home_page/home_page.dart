import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/cart/presentation/cart_screen.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/components/image_network_builder.dart';
import 'package:muaho/features/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/features/home/domain/models/home/product_category_home.dart';
import 'package:muaho/features/home/domain/models/home/slide_banner_entity.dart';
import 'package:muaho/features/home/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:muaho/features/search/hot_search/ui/hot_search_screen.dart';
import 'package:muaho/features/search/search_shop/ui/search_shop.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'model/home_page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _currentBannerIndexNotifier = ValueNotifier<int>(0);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<HomePageBloc>(
      create: (ctx) => inject()..add(HomePageRequestEvent()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Builder(builder: (ctx) {
            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: BlocBuilder<HomePageBloc, HomePageState>(
                  buildWhen: (pre, curr) =>
                      curr is HomePageSuccessState || curr is HomePageLoading,
                  builder: (ctx, state) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 78),
                      child: _handleBuilder(state, ctx),
                    );
                  },
                ));
          }),
        ),
      ),
    );
  }

  Widget _handleBuilder(HomePageState state, BuildContext ctx) {
    if (state is HomePageSuccessState) {
      return _handleHomePageBuilder(
        state.homePageModel,
        ctx,
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Padding _userInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ImageNetworkBuilder(
                imgUrl: "https://picsum.photos/50",
                size: Size.square(50),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.home_hiUser.translate(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (pre, curr) => curr is UserNameState,
                        builder: (context, state) {
                          return Text(
                            (state is UserNameState &&
                                    state.userName.isNotEmpty)
                                ? state.userName
                                : "Guest",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColorLight),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CartScreen.routeName,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 24,
                      ),
                      Positioned(
                        right: 1,
                        top: 1,
                        child: _redDotBuilder(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 40,
              height: 40,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                child: Icon(
                  Icons.search_outlined,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _redDotBuilder() {
    return BlocBuilder<CartUpdateBloc, CartUpdateState>(
      builder: (context, state) {
        return Visibility(
          visible: (state is CartUpdatedState &&
              state.cartInfo.productStores.isNotEmpty),
          child: Container(
            width: 7,
            height: 7,
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        );
      },
    );
  }

  Widget _productCategoriesBuild(HomePageModel state, BuildContext ctx) {
    List<Row> rows = [];
    var list = state.productCategories;
    for (var i = 0; i < list.length; i += 4) {
      Row productCategoryRowBuilder = _productCategoryRowBuilder(
        list[i],
        list.getOrNull(i + 1),
        list.getOrNull(i + 2),
        list.getOrNull(i + 3),
      );
      rows.add(productCategoryRowBuilder);
    }
    return Column(
      children: rows,
    );
  }

  Row _productCategoryRowBuilder(
    ProductCategoryHomeEntity category1,
    ProductCategoryHomeEntity? category2,
    ProductCategoryHomeEntity? category3,
    ProductCategoryHomeEntity? category4,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _productCategoryBuilder(category1),
        ),
        Expanded(
          child: category2 != null
              ? _productCategoryBuilder(category2)
              : SizedBox.shrink(),
        ),
        Expanded(
          child: category3 != null
              ? _productCategoryBuilder(category3)
              : SizedBox.shrink(),
        ),
        Expanded(
          child: category4 != null
              ? _productCategoryBuilder(category4)
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _productCategoryBuilder(ProductCategoryHomeEntity e) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              SearchShopScreen.routeName,
              arguments: SearchShopByCategory(
                categoryId: e.id,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ImageNetworkBuilder(
                    imgUrl: e.thumbUrl,
                    size: Size.square(1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.name,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _handleHomePageBuilder(HomePageModel homePageModel, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _userInfo(),
        Visibility(
          visible: homePageModel.slideBannerEntity.length > 0 ? true : false,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                LocaleKeys.home_newsTitle.translate(),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
          ),
        ),
        _buildStateSlideBanner(homePageModel, ctx),
        _buildSlideBannerIndicator(homePageModel, ctx),
        Visibility(
          visible: homePageModel.slideBannerEntity.length > 0 ? true : false,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 32, top: 16, bottom: 8, right: 32),
            child: Container(
              height: 1.5,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        _titleCategory(),
        _productCategoriesBuild(homePageModel, ctx),
        SizedBox(
          height: 72,
        ),
      ],
    );
  }

  Widget _buildStateSlideBanner(HomePageModel model, BuildContext context) {
    return model.slideBannerEntity.length > 0
        ? _buildPageView(model.slideBannerEntity, context)
        : Container();
  }

  Widget _buildSlideBannerIndicator(HomePageModel model, BuildContext context) {
    return model.slideBannerEntity.length > 0
        ? _buildCircleIndicator(model.slideBannerEntity.length)
        : Container();
  }

  _buildPageView(List<SlideBannerEntity> banners, BuildContext ctx) {
    return CarouselSlider(
      options: CarouselOptions(
        reverse: false,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        onPageChanged: (index, reason) =>
            {_currentBannerIndexNotifier.value = index},
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<DeeplinkHandleBloc>(context).add(
                  OpenInternalDeeplinkEvent(deepLinkUrl: banner.deepLinkUrl),
                );
              },
              child: FittedBox(
                fit: BoxFit.fill,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: ImageNetworkBuilder(
                        imgUrl: banner.thumbUrl,
                        size: Size(600, 280),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 24,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Theme.of(context).backgroundColor),
                        child: SizedBox(
                          width: MediaQuery.of(ctx).size.width,
                          height: MediaQuery.of(ctx).size.width / 6,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    banner.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    banner.subject,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  _buildCircleIndicator(int countItem) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentBannerIndexNotifier,
        builder: (_, value, child) => AnimatedSmoothIndicator(
          activeIndex: value,
          count: countItem,
          effect: WormEffect(
            dotHeight: 4,
            dotWidth: 4,
            activeDotColor: Theme.of(context).primaryColorLight,
            dotColor: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }

  _titleCategory() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    LocaleKeys.home_shopCategory.translate(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
