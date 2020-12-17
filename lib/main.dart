import 'package:flutter/material.dart';
import 'package:mangareader/model/history.dart';
import 'package:mangareader/screens/homePage.dart';
import 'package:mangareader/services/themeNotifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/themePage.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocDir.path)
    ..registerAdapter(HistoryAdapter());
  var box = await Hive.openBox('history');

  SharedPreferences.getInstance().then((prefs) {
    var themeIndex = prefs.getInt('ctx') ?? 0;
    print(' Index is $themeIndex');
    runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(themes[themeIndex]),
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}
