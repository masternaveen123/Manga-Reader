import 'package:flutter/material.dart';
import 'package:mangareader/models/chapters.dart';
import 'package:mangareader/services/api_manager.dart';

import 'mangaReader.dart';

class HistoryMangaView extends StatefulWidget {
  HistoryMangaView({this.v, this.index});
  var v;
  int index;

  @override
  _HistoryMangaViewState createState() => _HistoryMangaViewState();
}

class _HistoryMangaViewState extends State<HistoryMangaView> {
  Future<Chapter> _chapters;
  @override
  void initState() {
    _chapters = APIChapters(
      source: widget.v[widget.index].source,
      chapter: widget.v[widget.index].sourceSpecificName,
    ).getChapter();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                widget.v[widget.index].currentTitle,
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
                    widget.v[widget.index].thumbnail,
//                    filterQuality: FilterQuality.high,
                    height: 200,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 10,
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
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        var chapter = snapshot.data.data[index];
                        print(widget.v[widget.index].currentChapter);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: widget.v[widget.index].currentChapter !=
                                    chapter.chapterNumber
                                ? Theme.of(context).accentColor
                                : Colors.red,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            onPressed: () {
                              // print(chapter.link);
                              // print(widget.v[index].sourceSpecificName);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MangaReader(
                                      link: chapter.link,
                                      source: widget.v[widget.index].source,
                                      thumbnail:
                                          widget.v[widget.index].thumbnail,
                                      currentChapter:
                                          widget.v[widget.index].currentChapter,
                                      currentTitle:
                                          widget.v[widget.index].currentTitle,
                                      sourceSpecificName: widget
                                          .v[widget.index].sourceSpecificName,
                                    ),
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
