import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangareader/models/manga.dart';
import 'package:shimmer/shimmer.dart';

import 'mangaView.dart';

class MangaViewScroll extends StatelessWidget {
  const MangaViewScroll({
    // Key key,
    this.mangaModel,
    this.source,
  });

  final Future<Manga> mangaModel;
  final source;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<Manga>(
        future: mangaModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index) {
                  var manga = snapshot.data.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MangaView(
                            manga: manga,
                            source: source,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 220,
                      width: 150,
                      child: Card(
                        color: Colors.white,
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(5),
//                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              manga.imageUrl,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                manga.title,
//                                  softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ShimmerCard(),
                  ShimmerCard(),
                  ShimmerCard(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
//      width: 150,
      child: SizedBox(
        child: Card(
          child: Column(
            children: [
              Shimmer.fromColors(
                period: Duration(milliseconds: 500),
                highlightColor: Colors.white,
                baseColor: Colors.grey[350],
                child: Container(
                  height: 200,
                  width: 150,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  period: Duration(milliseconds: 500),
                  child: Container(
                    width: 150,
                    height: 20,
                    color: Colors.grey,
                  ),
                  baseColor: Colors.grey[350],
                  highlightColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        height: 220,
        width: 150,
      ),
    );
  }
}
