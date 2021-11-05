import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/colors.dart';
import 'package:flutter_opinion_monitor/_utils/hi_state.dart';
import 'package:flutter_opinion_monitor/_utils/http/core/hi_error.dart';
import 'package:flutter_opinion_monitor/_utils/http/dao/home_dao.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/_utils/toast.dart';
import 'package:flutter_opinion_monitor/model/home_mo.dart';
import 'package:flutter_opinion_monitor/model/video_model.dart';
import 'package:flutter_opinion_monitor/pages/home_tab_page.dart';
import 'package:flutter_opinion_monitor/widgets/navigation_bar.dart';
import 'package:flutter_opinion_monitor/widgets/underline_indicator.dart';
import 'package:logging/logging.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final Logger logger = Logger("_HomePageState");
  late TabController _tabController;

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.routeListener);
    _tabController = TabController(length: categoryList.length, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.routeListener);
    _tabController.dispose();
    super.dispose();
  }

  void routeListener(current, pre) {
    if (widget == current.page || current.page is HomePage) {
      logger.fine("open HomePage");
    } else if (widget == pre?.page || pre?.page is HomePage) {
      logger.fine("background process HomePage");
    }
  }

  onJumpToDetail() {
    HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {
      "videoMo": VideoModel(vid: "123123"),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            NavigationBar(child: _appBar()),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(
                child: TabBarView(
              controller: _tabController,
              children: categoryList
                  .map((e) => HomeTabPage(
                      name: e.name,
                      bannerList: e.name == "推荐" ? bannerList : null))
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: categoryList.map((category) {
        return Tab(
          child: Text(
            category.name,
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
      labelColor: Colors.black,
      indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round, // Set your line endings.
          borderSide: BorderSide(
            color: HiColors.pink,
            width: 3,
          ),
          insets: EdgeInsets.only(left: 5, right: 5)),
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get("推荐");
      if (result.categoryList != null) {
        _tabController =
            TabController(length: result.categoryList!.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
      });
    } on NeedLogin catch (e) {
      logger.severe(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      logger.severe(e);
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: (){},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("assets/images/avatar.png")
              ),
            ),
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
