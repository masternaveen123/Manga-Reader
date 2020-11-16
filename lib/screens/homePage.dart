import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mangareader/models/manga.dart';
import 'package:mangareader/services/api_manager.dart';
import 'package:mangareader/services/providerClass.dart';
import 'package:mangareader/widgets/mangaScrollView.dart';
import 'package:mangareader/widgets/mangaView.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Manga> _hotUp;
  Future<Manga> _latestUp;
  int _value = 0;

  @override
  void initState() {
    _hotUp = APIHotUp(_value).getManga();
    _latestUp = APILatestUp(_value).getManga();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
//          backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manga Reader',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          DropdownButton(
              value: _value,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              items: [
                DropdownMenuItem(
                  child: Text("Source 1"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("Source 2"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Source 3"),
                  value: 2,
                )
              ],
              onChanged: (value) {
                setState(() {
                  _value = value;
                  _hotUp = APIHotUp(_value).getManga();
                  _latestUp = APILatestUp(_value).getManga();
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hot Updates',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                height: 200,
                child: MangaViewScroll(
                  mangaModel: _hotUp,
                  source: _value,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Latest Updates',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
              height: 200,
                child: MangaViewScroll(
                  mangaModel: _latestUp,
                  source: _value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
