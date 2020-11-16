import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangareader/models/chapters.dart';
import 'package:mangareader/models/manga.dart';
import 'package:mangareader/services/api_manager.dart';

class MangaView extends StatefulWidget {
  Datum _manga;
  var source;

  MangaView(this._manga, this.source);

  @override
  _MangaViewState createState() => _MangaViewState();
}

class _MangaViewState extends State<MangaView> {
  Future<Chapter> _chapters;
  @override
  void initState() {
    _chapters = APIChapters(
            chapter: widget._manga.sourceSpecificName, source: widget.source)
        .getChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._manga.sourceSpecificName);
    print(widget.source);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          'Manga',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._manga.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget._manga.imageUrl,
//                    filterQuality: FilterQuality.high,
                    height: 200,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Author : ${widget._manga.additionalInfo.author}' ??
                          ''),
                      Text('Rating : ${widget._manga.additionalInfo.rating}' ??
                          ''),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Chapters',
                style: Theme.of(context).textTheme.headline6,
              ),
              FutureBuilder<Chapter>(
                future: _chapters,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                      itemBuilder: (context, index) {
                        var chapter = snapshot.data.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.yellowAccent.withOpacity(0.4),
                            elevation: 0,
                            onPressed: () {},
                            child: Text(
                              chapter.chapterNumber,
//                              softWrap: false,
//                              overflow: TextOverflow.visible,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
