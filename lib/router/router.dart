import "dart:core";

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/http/dao/login_dao.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/_utils/toast.dart';
import 'package:flutter_opinion_monitor/model/video_model.dart';
import 'package:flutter_opinion_monitor/pages/home_page.dart';
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
  VideoModel? videoModel;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

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
      page = pageWrap(HomePage(onJumpToDetail: (VideoModel value) {
        this.videoModel = value;
        notifyListeners();
      }));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
      _routeStatus = RouteStatus.detail;
      notifyListeners();
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage(
        onJumpToRegistration: () {
          _routeStatus = RouteStatus.registration;
          notifyListeners();
        },
        onLoginSuccess: () {
          _routeStatus = RouteStatus.home;
          notifyListeners();
        },
      ));
    }
    pages = [...tmpPages, page];
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
            pages.removeLast();
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
