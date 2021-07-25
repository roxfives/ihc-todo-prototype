import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      key: _scaffoldKey,
        title: Text(AppLocalizations.of(context)!.about_title),
        // actions: [
        //   IconButton(
        //     tooltip: 'Notificações', //localization.starterAppTooltipFavorite,
        //     icon: const Icon(
        //       Icons.notifications,
        //     ),
        //     onPressed: () {
        //       _scaffoldKey.currentState!.openEndDrawer();
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
              leading: const Icon(Icons.people),
              title: Text(AppLocalizations.of(context)!.authors),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: Text(AppLocalizations.of(context)!.legal),
              onTap: () {
                Navigator.pushNamed(context, '/legal');
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}