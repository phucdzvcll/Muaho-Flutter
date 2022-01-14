import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/presentation/chat-support/chat_support.dart';
import 'package:muaho/presentation/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/presentation/deeplink/deeplink_navigator.dart';
import 'package:muaho/presentation/home/history/history_page.dart';
import 'package:muaho/presentation/home/home_page/home_page.dart';
import 'package:muaho/presentation/home/setting_page/setting_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(keepPage: false);
  final DeepLinkNavigator deepLinkNavigator = DeepLinkNavigator();
  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeeplinkHandleBloc, DeeplinkHandleState>(
      listener: (ctx, state) async {
        if (state is DeepLinkState) {
          deepLinkNavigator.open(
              context: context, deepLinkDestination: state.deepLinkDestination);
        }
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Center(
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavigationBarItem(Icons.home, 0),
                    _buildNavigationBarItem(Icons.dynamic_feed, 1),
                    _buildNavigationBarItem(Icons.account_circle, 2),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 86,
            child: CircleAvatar(
              radius: 33,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Theme.of(context).cardColor,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ChatScreen.routeName,
                    );
                  },
                  child: Swing(
                    duration: Duration(milliseconds: 1200),
                    delay: Duration(milliseconds: 200),
                    child: ZoomIn(
                      duration: Duration(milliseconds: 1200),
                      child: Icon(
                        Icons.contact_support,
                        size: 32,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
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
