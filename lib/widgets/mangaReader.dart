import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mangareader/model/history.dart';
import 'package:mangareader/models/images.dart';
import 'package:mangareader/services/api_manager.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MangaReader extends StatefulWidget {
  String link;
  var source;
  String thumbnail;
  String currentChapter;
  String currentTitle;
  String sourceSpecificName;

  MangaReader(
      {this.link,
      this.source,
      this.thumbnail,
      this.currentChapter,
      this.currentTitle,
      this.sourceSpecificName});
  @override
  _MangaReaderState createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader> {
  Future<Images> _images;

  static double _lowervalue = 1.0;
  static double _uppervalue = 20.0;
  RangeValues values = RangeValues(_lowervalue, _uppervalue);

  @override
  void initState() {
    _images = APIImages(
      link: widget.link,
      source: widget.source,
    ).getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MangaSlider(
            images: _images,
            currentChapter: widget.currentChapter,
            thumbnail: widget.thumbnail,
            source: widget.source,
            sourceSpecificName: widget.sourceSpecificName,
            currentTitle: widget.currentTitle,
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: RangeSlider(
          //     min: _lowervalue,
          //     max: _uppervalue,
          //     values: values,
          //     onChanged: (value) {
          //       setState(() {
          //         values = value;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class MangaSlider extends StatefulWidget {
  const MangaSlider(
      {Key key,
      @required Future<Images> images,
      this.thumbnail,
      this.currentChapter,
      this.currentTitle,
      this.sourceSpecificName,
      this.source})
      : _images = images,
        super(key: key);

  final Future<Images> _images;
  final String thumbnail;
  final String currentChapter;
  final String currentTitle;
  final String sourceSpecificName;
  final int source;

  @override
  _MangaSliderState createState() => _MangaSliderState();
}

class _MangaSliderState extends State<MangaSlider> {
  @override
  Widget build(BuildContext context) {
    PageController _pageController;

    return FutureBuilder<Images>(
      future: widget._images,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: snapshot.data.data.imageUrl.length,
            loadingBuilder: (context, event) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (context, index) {
              var image = snapshot.data.data.imageUrl;
              if (index + 1 < image.length) {
                var str = image['${index + 1}'].substring(0, 8);

                print('String : $str');
                image['${index + 1}'].substring(0, 8) == 'https://'
                    ? precacheImage(
                        NetworkImage(
                          image['${index + 2}'],
                        ),
                        context)
                    : precacheImage(
                        NetworkImage(
                          'https://${image['${index + 2}']}',
                        ),
                        context);
              }

              print(
                  'Image url : ${snapshot.data.data.imageUrl['${index + 1}']}');
              // print('source  :  ${widget.sourceSpecificName}');
              _class(widget.currentTitle, widget.thumbnail, widget.source,
                      widget.currentChapter, index, widget.sourceSpecificName)
                  ._openBox();
              // _openBox(widget.currentTitle, widget.thumbnail, widget.source,
              //     widget.currentChapter, index, widget.sourceSpecificName);
              // print(widget.)
              print('Thumbnail : $index');
              return PhotoViewGalleryPageOptions(
                tightMode: true,
                imageProvider:
                    image['${index + 1}'].substring(0, 8) == 'https://'
                        ? NetworkImage(
                            image['${index + 1}'],
                          )
                        : NetworkImage(
                            'https://${image['${index + 1}']}',
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
    );
  }
}

class _class {
  String currentTitle;
  String thumbnail;
  int source;
  String currentChapter;
  int currentPage;
  String sourceSpecificName;

  _class(this.currentTitle, this.thumbnail, this.source, this.currentChapter,
      this.currentPage, this.sourceSpecificName);

  Future<void> _openBox() async {
    var box = await Hive.openBox('history',
        keyComparator: (dynamic k1, dynamic k2) => 1);
    var len = box.length;
    print(' ++ :: $sourceSpecificName--$source   ::: $len');
    // for (var i = 0; i < 100000; i++) {
    //   print(i);
    // }
    box.put(
        '$sourceSpecificName++$source',
        History('$currentTitle', '$thumbnail', source, '$currentChapter',
            '$currentPage', '$sourceSpecificName'));
    // print('Indexes  : ${box.getAt(4).toString()}');
    // print(box.get('$sourceSpecificName++$source'));
    // var c=box.get('$sourceSpecificName++$source');
    // print(c.sourceSpecificName);
  }
}
//
// Future<void> _openBox(String currentTitle, String thumbnail, int source,
//     String currentChapter, int currentPage, String sourceSpecificName) {
//   String currentTitle;
//   String thumbnail;
//   int source;
//   String currentChapter;
//   int currentPage;
//   String sourceSpecificName;
//
//   _openBox(currentTitle, thumbnail, source, currentChapter, currentPage,
//       sourceSpecificName);
//   var box = Hive.openBox('history');
//
//   print(' ++ :: $currentTitle');
//
//   // box.put('$sourceSpecificName$source', value);
// }

// Future _openBox1() async {
//   String currentTitle;
//   String thumbnail;
//   int source;
//   String currentChapter;
//   String currentPage;
//   String sourceSpecificName;
//
//   var box = await Hive.openBox('history');
// }
