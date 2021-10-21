import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/presentation/home/product_catrgory/product_category_bloc.dart';
import 'package:muaho/presentation/home/slide_banner/slide_banner_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentBannerIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyTheme.backgroundColor,
          body: _body(),
        ),
      ),
    );
  }

  Center _body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(MyTheme.radiusSize),
                  child: Image.network("https://picsum.photos/50"),
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
                              "Hello",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Ngọc Thanh",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(color: MyTheme.primaryColor)),
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
                      border: Border.all(color: MyTheme.borderLineColor),
                      borderRadius: BorderRadius.circular(MyTheme.radiusSize),
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.borderLineColor),
                    borderRadius: BorderRadius.circular(MyTheme.radiusSize),
                  ),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.search_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(MyTheme.paddingSize),
              child: Text(
                "Mua gì hôm nay?",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: MyTheme.lessImportantTextColor),
              ),
            ),
          ),
          BlocBuilder<SlideBannerBloc, SlideBannerState>(
            builder: (ctx, state) {
              return _slideBannerBuilder(state, ctx);
            },
          ),
          // _titleCategory(),
        ],
      ),
    );
  }

  Widget _productCategoriesBuild(ProductCategoryState state) {
    if (state is ProductCategoryError) {
      return Container(
        child: Text("Error"),
      );
    } else if (state is ProductCategoryLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ProductCategorySuccess) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _titleCategory(),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 100 / 150,
              physics: BouncingScrollPhysics(),
              children: state.productCategories
                  .map(
                    (e) => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.network(e.thumbUrl)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(e.name),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: Text("fwsdfsdfdsf"),
      );
    }
  }

  _slideBannerBuilder(SlideBannerState slideBannerState, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildStateSlideBanner(slideBannerState, ctx),
        _buildSlideBannerIndicator(slideBannerState, ctx),
        BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (ctx, state) {
            return _productCategoriesBuild(state);
          },
        ),
      ],
    );
  }

  Widget _buildStateSlideBanner(SlideBannerState state, BuildContext context) {
    if (state is SlideBannerLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SlideBannerError) {
      return Container(
        child: Text("Error"),
      );
    } else if (state is SlideBannerOnClick) {
      return Container();
    } else if (state is SlideBannerSuccess) {
      return _buildPageView(state.slideBannerEntity);
    } else {
      return Container();
    }
  }

  Widget _buildSlideBannerIndicator(
      SlideBannerState state, BuildContext context) {
    if (state is SlideBannerLoading) {
      return Center();
    } else if (state is SlideBannerError) {
      return Container();
    } else if (state is SlideBannerOnClick) {
      return Container();
    } else if (state is SlideBannerSuccess) {
      return _buildCircleIndicator(state.slideBannerEntity.length);
    } else {
      return Container();
    }
  }

  _buildPageView(List<SlideBannerEntity> banners) {
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
      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      i.thumbUrl,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 24,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          color: Theme.of(context).backgroundColor),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6,
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
                                  i.description,
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
                                  i.subject,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.subtitle1,
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
            activeDotColor: MyTheme.primaryButtonColor,
            dotColor: MyTheme.lessImportantTextColor,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, top: 16, bottom: 8, right: 32),
              child: Container(
                height: 1.5,
                color: MyTheme.spacingColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(MyTheme.paddingSize),
                  child: Text(
                    "Danh mục cửa hàng",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: MyTheme.lessImportantTextColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(MyTheme.paddingSize),
                  child: Text(
                    "Xem tất cả",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 14, color: Theme.of(context).primaryColor),
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
