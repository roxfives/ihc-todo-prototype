import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/widgets/action_button.dart';
import 'package:todo_app/widgets/board_view.dart';
import 'package:todo_app/widgets/expandable_fab.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class BoardLists extends StatefulWidget {
  const BoardLists({Key? key}) : super(key: key);

  @override
  State<BoardLists> createState() => _BoardListsState();
}

class _BoardListsState extends State<BoardLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            // localization.demoAppBarTitle,
            'Board Principal'),
        actions: [
          IconButton(
            tooltip: 'Notificações', //localization.starterAppTooltipFavorite,
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      body: Center(child: BoardViewExample()),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => Navigator.pushNamed(context, '/editCard'),
            icon: const Icon(Icons.add_task),
          ),
          ActionButton(
            onPressed: () => Navigator.pushNamed(context, '/editCard'),
            icon: const Icon(Icons.playlist_add),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  'O que vamos fazer hoje, ' +
                      (FirebaseAuth.instance.currentUser?.displayName ??
                          'Usuário') +
                      '?',
                  style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor: 0.6,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
            ),
            ListTile(
              title: Text('Board Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Sem notificações no momento',
                      style: DefaultTextStyle.of(context).style.apply(
                          fontSizeFactor: 0.3,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
