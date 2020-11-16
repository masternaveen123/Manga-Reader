import 'package:flutter/material.dart';
import 'package:mangareader/models/manga.dart';

import 'mangaView.dart';

class MangaViewScroll extends StatelessWidget {
  const MangaViewScroll({
    Key key,
    @required Future<Manga> mangaModel,
    this.source,
  })  : _mangaModel = mangaModel,
        super(key: key);

  final Future<Manga> _mangaModel;
  final source;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Manga>(
      future: _mangaModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                var manga = snapshot.data.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaView(manga, source),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 120,
                    child: Card(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(5),
//                      ),
                      child: Column(
                        children: [
                          Image.network(
                            manga.imageUrl,
                            fit: BoxFit.fill,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                manga.title,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
//                                        manga.additionalInfo.rating == '0'
//                                            ? Text('a')
//                                            : Row(
//                                                children: [
//                                                  Icon(
//                                                    Icons.star,
//                                                    color: Colors.black87,
//                                                  ),
//                                                  Text(
//                                                    manga.additionalInfo.rating,
//                                                  ),
//                                                ],
//                                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }
      },
    );
  }
}
