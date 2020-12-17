import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangareader/services/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map<Color, Color> colors = {
//   Colors.red.shade300: Colors.yellowAccent.withOpacity(0.4),
//   Colors.purpleAccent: Colors.purple,
//   Colors.black87: Colors.white,
// };
final redTheme = ThemeData(
  primaryColor: Colors.red.shade300,
  accentColor: Colors.yellowAccent,
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.red.shade300,
  iconTheme: IconThemeData(color: Colors.black87),
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.black,
    ),
    headline5: TextStyle(
      color: Colors.black.withOpacity(0.60),
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  ),
);
final purpleTheme = ThemeData(
  primaryColor: Colors.black,
  accentColor: Colors.purpleAccent,
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.purpleAccent),
  textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
      ),
      headline5: TextStyle(
          color: Colors.purpleAccent.withOpacity(0.60),
          fontSize: 40,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.purpleAccent,
      ),
      bodyText2: TextStyle(color: Colors.white)),
);
final darkPurpleTheme = ThemeData(
  primaryColor: Colors.black,
  accentColor: Color(0xFF892cdc),
  backgroundColor: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  iconTheme: IconThemeData(color: Color(0xFF892cdc)),
  textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black
          // color: Color(0xFF892cdc),
          ),
      headline5: TextStyle(
          color: Color(0xFF892cdc).withOpacity(0.60),
          fontSize: 40,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Color(0xFF892cdc),
      ),
      bodyText2: TextStyle(color: Colors.white)),
);
final kyeTheme = ThemeData(
  primaryColor: Color(0xFF8360c3),
  accentColor: Color(0xFF2ebf91),
  backgroundColor: Colors.blue,
  scaffoldBackgroundColor: Color(0xFF8360c3),
  iconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black
          // color: Color(0xFF892cdc),
          ),
      headline5: TextStyle(
        color: Colors.black.withOpacity(0.60),
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.black,
      ),
      bodyText2: TextStyle(color: Colors.white)),
);

List<ThemeData> themes = [redTheme, purpleTheme, darkPurpleTheme, kyeTheme];

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Theme',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          // print(colors.entries.toList()[index].value);
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {
                themeNotifier.setTheme(themes[index]);
                // SharedPreferences.setMockInitialValues({});
                SharedPreferences prefs = await SharedPreferences.getInstance();
                // print('Previous Prefs is ${prefs.getInt('index')}');
                prefs.setInt('ctx', index);
                print('New Prefs is ${prefs.getInt('ctx')}');
              },
              child: Card(
                elevation: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: themes[index].primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: themes[index].accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
