import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/pages/home_page.dart';
import 'package:flutter_opinion_monitor/pages/login_page.dart';
import 'package:flutter_opinion_monitor/pages/registration_page.dart';
import 'package:flutter_opinion_monitor/pages/video_detail_page.dart';

MaterialPage pageWrap(Widget widget) {
  return MaterialPage(key: ValueKey(widget.hashCode), child: widget);
}

enum RouteStatus { login, registration, home, detail, unknown }

RouteStatus getRouteStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
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
