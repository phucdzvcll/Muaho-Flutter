import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muaho/common/my_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // double maxWidth;
  // double maxHeight;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  _buildPageView() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 280.0,
          onPageChanged: (index, reason) =>
              {_currentPageNotifier.value = index},
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: 600,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }

  _buildCircleIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: MyTheme.paddingSize / 2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          dotColor: MyTheme.primaryButtonColor,
          itemCount: 5,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        body: Center(
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
                          borderRadius:
                              BorderRadius.circular(MyTheme.radiusSize),
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
              Stack(
                children: <Widget>[
                  _buildPageView(),
                ],
              ),
              _buildCircleIndicator(),
            ],
          ),
        ),
// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
