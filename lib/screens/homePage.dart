import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:mangareader/models/manga.dart';
import 'package:mangareader/models/mangaSource.dart';
import 'package:mangareader/screens/themePage.dart';
import 'package:mangareader/services/api_manager.dart';
import 'package:mangareader/widgets/customBottomNavBar.dart';
import 'package:mangareader/widgets/historyMangaView.dart';
import 'package:mangareader/widgets/mangaScrollView.dart';
import 'package:mangareader/widgets/search.dart';
import 'package:settings_ui/settings_ui.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //     print(index);
  //   });
  // }

  Future<Manga> _hotUp;
  Future<Manga> _latestUp;
  Future<MangaSource> _mangaSource;
  // Future<SearchSource> _searchData;
  int _value = 0;

  @override
  void initState() {
    _hotUp = APIHotUp(_value).getManga();
    _latestUp = APILatestUp(_value).getManga();
    _mangaSource = APIMangaSource().getSources();
    // _searchData = APISearchSource(source: _value).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeView(hotUp: _hotUp, value: _value, latestUp: _latestUp),
      SearchWid(
        source: _value,
        // key: ,
        // searchData: _searchData,
      ),
      History(),
      Settings(),
    ];
    // _hotUp = null;
    // _latestUp = null;
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
//          backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manga Reader',
          // overflow: TextOverflow.fade,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
          ),
        ),
        actions: [
          FutureBuilder<MangaSource>(
            future: _mangaSource,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print("1");
                // print(snapshot.data.toString().length);
                // print('1done');
                return DropdownButton(
                  // hint: Text(
                  //   'Sources',
                  // ),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                      _hotUp = APIHotUp(_value).getManga();
                      _latestUp = APILatestUp(_value).getManga();
                      // _searchData = APISearchSource(source: _value).getData();
                    });
                  },
                  // items: snapshot.data.,
                  items: List.generate(
                    snapshot.data.sources.length,
                    (index) => DropdownMenuItem(
                      child: Text(
                        '${snapshot.data.sources[index].shortName}',
                        style: TextStyle(
                            color: _value == index ? Colors.red : Colors.black
                            // fontSize: 15,
                            ),
                      ),
                      value: index,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // SearchWid(
          //   source: _value,
          //   // key: ,
          //   // searchData: _searchData,
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        defaultSelectedIndex: 0,
        onChange: (val) {
          if (val != _currentIndex) {
            setState(() {
              _currentIndex = val;
            });
          }
        },
      ),

      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //       Theme.of(context).primaryColor,
          //       Theme.of(context).accentColor
          //     ])),
          child: _children[_currentIndex],
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final box = Hive.box('history');
  List v = List();
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < box.length; i++) {
      v.add(box.getAt(i));
    }
    v.sort((a, b) => b.currentTime.compareTo(a.currentTime));
    for (int i = 0; i < box.length; i++) {
      print(' :::: ${v[i].currentChapter} ,${v[i].currentTime}');
    }
    print('Box Lenght : ${box.length}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            box.clear();
            v.clear();
            print('pressed');
          });
        },
      ),
      body: ListView.builder(
        itemCount: v.length,
        itemBuilder: (context, index) {
          if (v[index] != null) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () {},
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => {
                    setState(() {
                      box.delete(
                          '${v[index].sourceSpecificName}++${v[index].source}');
                      v.clear();
                    })
                  },
                ),
              ],
              key: ObjectKey(
                  '${v[index].sourceSpecificName}++${v[index].source}'),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryMangaView(
                        index: index,
                        v: v,
                      ),
                    ),
                  );
                },
                title: Text(
                  v[index].currentTitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                subtitle: Text(
                  v[index].currentChapter,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                // subtitle: Text(box.getAt(index).source.toString()),
                leading: Image.network(
                  v[index].thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Start reading to see history',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
        },
      ),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SettingsList(
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Theme.of(context).primaryColor,
        // darkBackgroundColor: Colors.blue,
        // lightBackgroundColor: Colors.blue,
        sections: [
          SettingsSection(
            titleTextStyle: Theme.of(context).textTheme.bodyText1,
            title: 'Settings',
            tiles: [
              SettingsTile(
                titleTextStyle: Theme.of(context).textTheme.bodyText1,
                title: 'Theme',
                leading: Icon(
                  Icons.color_lens,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThemePage(),
                      ));
                },
              ),
              SettingsTile(
                titleTextStyle: Theme.of(context).textTheme.bodyText1,
                title: 'Reader',
                leading: Icon(
                  Icons.library_books,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              SettingsTile(
                titleTextStyle: Theme.of(context).textTheme.bodyText1,
                title: 'Size',
                leading: Icon(
                  Icons.format_size,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    Key key,
    @required Future<Manga> hotUp,
    @required int value,
    @required Future<Manga> latestUp,
  })  : _hotUp = hotUp,
        _value = value,
        _latestUp = latestUp,
        super(key: key);

  final Future<Manga> _hotUp;
  final int _value;
  final Future<Manga> _latestUp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hot Updates',
            style: GoogleFonts.aBeeZee(
                textStyle: Theme.of(context).textTheme.bodyText1),
            // style: Theme.of(context).textTheme.bodyText1,
          ),
          MangaViewScroll(
            mangaModel: _hotUp,
            source: _value,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Latest Updates',
            style: GoogleFonts.aBeeZee(
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          MangaViewScroll(
            mangaModel: _latestUp,
            source: _value,
          ),
        ],
      ),
    );
  }
}
