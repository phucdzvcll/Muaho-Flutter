import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/presentation/chat-support/chat_support.dart';
import 'package:muaho/presentation/deeplink/deeplink_handle_bloc.dart';
import 'package:muaho/presentation/deeplink/deeplink_navigator.dart';
import 'package:muaho/presentation/home/history/history_page.dart';
import 'package:muaho/presentation/home/home_page/home_page.dart';
import 'package:muaho/presentation/home/setting_page/setting_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

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

  Container _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
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
                ),
              ),
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
