import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/modules/edit_card/screens/edit_card_screen.dart';
import 'package:todo_app/modules/login/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate
      // ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: "Test",
      home: EditCard(),
    );
  }
}

class AppBarDemo extends StatelessWidget {
  const AppBarDemo() : super();

  @override
  Widget build(BuildContext context) {
    // var localization = GalleryLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
            // localization.demoAppBarTitle,
            'App demo'),
        actions: [
          IconButton(
            tooltip: 'Favorite', //localization.starterAppTooltipFavorite,
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Search', //localization.starterAppTooltipSearch,
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<Text>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child:
                      Text('navigation1' //localization.demoNavigationRailFirst,
                          ),
                ),
                PopupMenuItem(
                  child: Text(
                      'navigation1' //localization.demoNavigationRailSecond,
                      ),
                ),
                PopupMenuItem(
                  child:
                      Text('navigation3' //localization.demoNavigationRailThird,
                          ),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.hello_world  //'Home' //localization.cupertinoTabBarHomeTab,
            ),
      ),
    );
  }
}
