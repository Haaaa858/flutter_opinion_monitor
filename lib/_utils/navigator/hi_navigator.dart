import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/bottom_navigator.dart';
import 'package:flutter_opinion_monitor/pages/login_page.dart';
import 'package:flutter_opinion_monitor/pages/registration_page.dart';
import 'package:flutter_opinion_monitor/pages/video_detail_page.dart';
import 'package:logging/logging.dart';

enum RouteStatus { login, registration, home, detail, unknown }

/// 路由跳转
typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

///

MaterialPage pageWrap(Widget widget) {
  return MaterialPage(key: ValueKey(widget.hashCode), child: widget);
}

RouteStatus getRouteStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unknown;
}

int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getRouteStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

/// 监听路由变化
/// 感知页面是否进入后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;
  final Logger logger = Logger("HiNavigator");

  RouteJumpListener? _jumpListener;
  // 路由
  RouteStatusInfo? _current;
  // 首页PageView 切换
  RouteStatusInfo? _bottomTab;

  List<RouteChangeListener> _listeners = [];

  HiNavigator._();

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  void onBottomTabChange(int index, Widget page) {
    if (_bottomTab != null && _bottomTab!.page == page) return;
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notifyRouteStackChanged(_bottomTab!);
  }

  void registerJumpListener(RouteJumpListener listener) {
    this._jumpListener = listener;
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  void notifyRouteStackChanged(
      List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(
        getRouteStatus(currentPages.last), currentPages.last.child);
    _notifyRouteStackChanged(current);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _jumpListener!.onJumpTo(routeStatus, args: args);
  }

  void _notifyRouteStackChanged(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }
    logger.fine(
        "route changed, current: ${current.page}, pre: ${_current?.page}");
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

abstract class _RouteChangListener {}

class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
