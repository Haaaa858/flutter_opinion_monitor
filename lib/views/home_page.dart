import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: appBarBuilder, routes: [],
      //routes: [PostsPage(), UsersRoute(), SettingsRouter()],
    );
  }

  PreferredSizeWidget appBarBuilder(_, tabsRouter) => AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('FlutterBottomNav'),
        centerTitle: true,
        leading: const AutoBackButton(),
      );
}
