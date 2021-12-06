import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/cart/cart_screen.dart';
import 'package:muaho/presentation/components/image_network_builder.dart';
import 'package:muaho/presentation/home/home_page/bloc/home_page_bloc.dart';
import 'package:muaho/presentation/sign_in/sign_in.dart';
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
    final SignInArguments arg =
        ModalRoute.of(context)!.settings.arguments as SignInArguments;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: BlocProvider<HomePageBloc>(
                create: (ctx) => HomePageBloc()..add(HomePageRequestEvent()),
                child: BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (ctx, state) {
                    return _handleBuilder(state, ctx, arg);
                  },
                ),
              ),
            )),
      ),
    );
  }

  Widget _handleBuilder(
      HomePageState state, BuildContext ctx, SignInArguments arguments) {
    if (state is HomePageSuccessState) {
      return _handleHomePageBuilder(state.homePageModel, ctx, arguments);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Padding _userInfo(SignInArguments arg) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(MyTheme.radiusSize),
            child: ImageNetworkBuilder(
              isSquare: true,
              imgUrl: "https://picsum.photos/50",
              width: 50,
              height: 50,
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
                        "Hello",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(arg.userName,
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
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CartScreen.routeName,
                    );
                  },
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 24,
                  ),
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
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
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

  Widget _productCategoriesBuild(HomePageModel state, BuildContext ctx) {
    final double imgSquareSize = (MediaQuery.of(ctx).size.width - 200) / 4;

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
            childAspectRatio: 0.7,
            physics: BouncingScrollPhysics(),
            children: state.productCategories
                .map(
                  (e) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ImageNetworkBuilder(
                              isSquare: true,
                              imgUrl: e.thumbUrl,
                              width: imgSquareSize,
                              height: imgSquareSize,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          e.name,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  _handleHomePageBuilder(HomePageModel homePageModel, BuildContext ctx,
      SignInArguments arguments) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _userInfo(arguments),
        Visibility(
          visible: homePageModel.slideBannerEntity.length > 0 ? true : false,
          child: Align(
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
              color: MyTheme.spacingColor,
            ),
          ),
        ),
        _productCategoriesBuild(homePageModel, ctx),
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
                    child: ImageNetworkBuilder(
                      isSquare: false,
                      imgUrl: i.thumbUrl,
                      width: 600,
                      height: 280,
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
