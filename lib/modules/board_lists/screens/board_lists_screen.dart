import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/list_provider.dart';

import 'package:todo_app/widgets/board_view.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class BoardLists extends StatefulWidget {
  const BoardLists({Key? key}) : super(key: key);

  @override
  State<BoardLists> createState() => _BoardListsState();
}

class _BoardListsState extends State<BoardLists> {
  final _listProvider = new ListProvider();

  void _navigateAndRefresh(BuildContext context) async {
    final lists = await _listProvider.fetchLists();

    if (lists.length > 0) {
      await Navigator.pushNamed(context, '/editCard');
      setState(() {});
    } else {
      final _noListsSnack = SnackBar(
          content: Text(AppLocalizations.of(context)!.create_list_first));

      ScaffoldMessenger.of(context).showSnackBar(_noListsSnack);
    }
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndRefresh(context),
        child: const Icon(Icons.add),
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
              leading: const Icon(Icons.exit_to_app),
              title: Text(AppLocalizations.of(context)!.sign_out),
              onTap: () {
                this.signOut().then((value) => {
                      Navigator.of(context).popUntil((route) => route.isFirst),
                      Navigator.popAndPushNamed(context, '/signin'),
                    });
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(AppLocalizations.of(context)!.help),
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(AppLocalizations.of(context)!.about),
              onTap: () {
                Navigator.pushNamed(context, '/about');
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

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
