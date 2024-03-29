import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangareader/models/chapters.dart';
import 'package:mangareader/models/manga.dart';
import 'package:mangareader/models/searchQuery.dart';
import 'package:mangareader/services/api_manager.dart';
import 'package:mangareader/widgets/mangaReader.dart';

class MangaView extends StatefulWidget {
  Datum manga = null;
  var source;
  SearchQueryData query = null;

  MangaView({this.manga, this.source, this.query});

  @override
  _MangaViewState createState() => _MangaViewState();
}

class _MangaViewState extends State<MangaView> {
  Future<Chapter> _chapters;
  @override
  void initState() {
    print("^^");
    print(widget.manga?.sourceSpecificName ?? widget.query?.sourceSpecificName);
    print(">>");
    _chapters = APIChapters(
      chapter:
          widget.manga?.sourceSpecificName ?? widget.query?.sourceSpecificName,
      source: widget.source,
    ).getChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.manga?.sourceSpecificName ?? widget.query?.sourceSpecificName);
    print(widget.source);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Manga',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.manga?.title ?? widget.query?.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.manga?.imageUrl ?? widget.query?.imageUrl,
//                    filterQuality: FilterQuality.high,
                    height: 200,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(
                  //       'Author : ${widget.manga?.additionalInfo.author}' ?? '',
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     Text('Rating : ${widget.manga.additionalInfo.rating}' ??
                  //         ''),
                  //   ],
                  // ),
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
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        var chapter = snapshot.data.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            onPressed: () {
                              print(chapter.link);
                              print(widget.manga?.sourceSpecificName ??
                                  widget.query?.sourceSpecificName);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MangaReader(
                                      link: chapter.link,
                                      source: widget.source,
                                      thumbnail: widget.manga?.imageUrl ??
                                          widget.query?.imageUrl,
                                      currentChapter: chapter.chapterNumber,
                                      currentTitle: widget.manga?.title ??
                                          widget.query?.title,
                                      sourceSpecificName:
                                          widget.manga?.sourceSpecificName ??
                                              widget.query.sourceSpecificName,
                                    ),
                                    // builder: (context) => MangaReader(
                                    //   link: chapter.link,
                                    //   source: widget.source,
                                    //   thumbnail: widget.manga.imageUrl,
                                    //   currentChapter:
                                    //       widget.manga.currentChapter,
                                    //   currentTitle: widget.manga.title,
                                    //   sourceSpecificName:
                                    //       widget.manga.sourceSpecificName,
                                    // ),
                                  ));
                            },
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
