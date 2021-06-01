import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/modules/board_lists/screens/board_lists_screen.dart';
import 'package:todo_app/modules/edit_card/screens/edit_card_screen.dart';
import 'package:todo_app/modules/login/screens/login_screen.dart';

void main() {
  runApp(TodoApp());
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => BoardLists(),
        '/editCard': (context) => EditCard(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: "Test",
      home: AppToolBar(),
    );
  }
}

class AppToolBar extends StatelessWidget {
  const AppToolBar() : super();

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
