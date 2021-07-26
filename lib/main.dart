import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_app/modules/board_lists/screens/board_lists_screen.dart';
import 'package:todo_app/modules/edit_card/screens/edit_card_screen.dart';
import 'package:todo_app/modules/legal/screens/about_screen.dart';
import 'package:todo_app/modules/legal/screens/legal_screen.dart';
import 'package:todo_app/modules/login/screens/login_screen.dart';
import 'package:todo_app/modules/login/screens/register_screen.dart';
import 'package:todo_app/modules/onboard/screens/onboard.dart';

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
class UnauthenticatedAppToolBar extends StatelessWidget {
  const UnauthenticatedAppToolBar() : super();

  @override
  Widget build(BuildContext context) {
    return  LoginScreen();
  }
}
class AuthenticatedAppToolBar extends StatelessWidget {
  const AuthenticatedAppToolBar() : super();

  @override
  Widget build(BuildContext context) {
    return  BoardLists();
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
          var isAuthenticated = FirebaseAuth.instance.currentUser != null;

          return MaterialApp(
            routes: {
              '/home': (context) => BoardLists(),
              '/register': (context) => RegisterScreen(),
              '/signin': (context) => LoginScreen(),
              '/editCard': (context) => EditCard(),
              '/about': (context) => AboutScreen(),
              '/legal': (context) => LegalScreen(),
              '/help': (context) => OnBoardScreen(),
            },
            onGenerateRoute: (RouteSettings settings) {
              final List<String>? pathElements = settings.name?.split('/');

              if (pathElements == null || pathElements[0] != '') {
                return null;
              }

              if (pathElements[1] == 'editCard') {
                if (pathElements.length > 3) {
                  return MaterialPageRoute<bool>(
                    builder: (BuildContext context) => EditCard(
                      listId: pathElements[2],
                      todoId: pathElements[3],
                    ),
                  );
                } else if (pathElements.length > 2) {
                  return MaterialPageRoute<bool>(
                    builder: (BuildContext context) => EditCard(
                      listId: pathElements[2],
                    ),
                  );
                } else {
                  return MaterialPageRoute<bool>(
                    builder: (BuildContext context) => EditCard(),
                  );
                }
              }
              return null;
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: "Test",
            home: isAuthenticated? AuthenticatedAppToolBar() : UnauthenticatedAppToolBar(),
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
