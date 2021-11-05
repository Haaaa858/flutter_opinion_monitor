import "dart:core";

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/http/dao/login_dao.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/bottom_navigator.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/_utils/toast.dart';
import 'package:flutter_opinion_monitor/model/home_mo.dart';
import 'package:flutter_opinion_monitor/pages/login_page.dart';
import 'package:flutter_opinion_monitor/pages/registration_page.dart';
import 'package:flutter_opinion_monitor/pages/video_detail_page.dart';

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  RouteStatus _routeStatus = RouteStatus.home;
  late BiliRoutePath routePath;
  VideoMo? videoModel;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerJumpListener(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail && args != null) {
        this.videoModel = args["videoMo"];
      }
      notifyListeners();
    }));
  }

  List<MaterialPage> pages = [];
  bool get hasLogin => LoginDao.isLogin();

  // 路由堆栈管理
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tmpPages = pages;
    if (index != -1) {
      tmpPages = tmpPages.sublist(0, index);
    }
    var page;

    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    tmpPages = [...tmpPages, page];
    HiNavigator.getInstance().notifyRouteStackChanged(tmpPages, pages);
    pages = tmpPages;

    return WillPopScope(
        onWillPop: () async =>
            !await navigatorKey.currentState!.maybePop(navigatorKey),
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (Route<dynamic> route, dynamic result) {
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast("请先登录");
                  return false;
                }
              }
            }

            // 控制是否可以返回
            if (!route.didPop(result)) {
              return false;
            }
            var tmpPages = [...pages];
            pages.removeLast();
            HiNavigator.getInstance().notifyRouteStackChanged(pages, tmpPages);

            return true;
          },
        ));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    // TODO: implement setNewRoutePath
    this.routePath = configuration;
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    }
    return _routeStatus;
  }
}
