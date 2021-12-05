import 'package:flutter/material.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/home/history/history_page.dart';
import 'package:muaho/presentation/home/home_page/home_page.dart';
import 'package:muaho/presentation/home/setting_page/setting_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController(keepPage: false);

  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.contact_support,
              size: 32,
            ),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: MyTheme.primaryButtonColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavigationBarItem(Icons.home, 0),
                  _buildNavigationBarItem(Icons.dynamic_feed_rounded, 1),
                  _buildNavigationBarItem(Icons.settings, 2),
                ],
              ),
            ),
          ),
          body: Center(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => {_currentPage.value = index},
              children: [
                const HomePage(),
                const HistoryPage(),
                const SettingPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildNavigationBarItem(IconData icon, int id) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _currentPage.value = id;
          _pageController.animateToPage(_currentPage.value,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        child: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (_, value, child) => Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: id == _currentPage.value
                    ? MyTheme.activeButtonColor
                    : MyTheme.primaryButtonColor,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
