import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/index.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/pages/favorite_page.dart';
import 'package:flutter_opinion_monitor/pages/home_page.dart';
import 'package:flutter_opinion_monitor/pages/profile_page.dart';
import 'package:flutter_opinion_monitor/pages/ranking_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColors = HiColors.pink;
  int _currentIndex = 0;
  static int initialPage = 0;
  bool _hasBuild = false;
  final PageController _controller = PageController(initialPage: 0);
  List<Widget> panels = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    panels = [HomePage(), RankingPage(), FavoritePage(), ProfilePage()];
    if (!_hasBuild) {
      HiNavigator.getInstance().onBottomTabChange(initialPage, panels[0]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (index) => onTap(index, pageChange: true),
        children: panels,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: _activeColors,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("热榜", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3)
        ],
      ),
    );
  }

  _bottomItem(String label, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColors),
        label: label);
  }

  void onTap(int value, {pageChange = false}) {
    if (!pageChange) {
      _controller.jumpToPage(value);
    } else {
      HiNavigator.getInstance().onBottomTabChange(value, panels[value]);
    }
    setState(() {
      this._currentIndex = value;
    });
  }
}
