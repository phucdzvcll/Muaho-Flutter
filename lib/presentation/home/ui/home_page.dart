import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/my_theme.dart';
import 'package:muaho/domain/models/slide_banner_entity.dart';
import 'package:muaho/presentation/home/slide_banner/slide_banner_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  _slideBanner(List<SlideBannerEntity> banners) {
    _buildPageView(banners);
    _buildCircleIndicator();
  }

  _buildPageView(List<SlideBannerEntity> banners) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 280.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (index, reason) =>
              {_currentPageNotifier.value = index},
        ),
        items: banners.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: 600,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Image.network(i.thumbUrl));
            },
          );
        }).toList(),
      ),
    );
  }

  _buildCircleIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentPageNotifier,
        builder: (_, value, child) => AnimatedSmoothIndicator(
          activeIndex: value,
          count: 5,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: MyTheme.primaryButtonColor,
            dotColor: MyTheme.lessImportantTextColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        body: BlocBuilder<SlideBannerBloc, SlideBannerState>(
          builder: (ctx, state) {
            return _body(state, ctx);
          },
        ),
// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Center _body(SlideBannerState slideBannerState, BuildContext context) {
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
          _buildStateSlideBanner(slideBannerState, context),
        ],
      ),
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
    } else if (state is SlideBannerSuccess) {
      return _slideBanner(state.slideBannerEntity);
    } else {
      return Container();
    }
    return Container();
  }
}
