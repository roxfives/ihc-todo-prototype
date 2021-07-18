import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_app/modules/board_lists/screens/board_lists_screen.dart';
import 'package:todo_app/modules/edit_card/screens/edit_card_screen.dart';
import 'package:todo_app/modules/login/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp());
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class TodoApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class AppToolBar extends StatelessWidget {
  const AppToolBar() : super();

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

class _AppState extends State<TodoApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          throw snapshot.error ?? new Error();
          // return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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

        // Otherwise, show something whilst waiting for initialization to complete
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: SvgPicture.asset("assets/images/logo.svg"));
      },
    );
  }
}
