// To parse this JSON data, do
//
//     final mangaSource = mangaSourceFromJson(jsonString);

import 'dart:convert';

MangaSource mangaSourceFromJson(String str) => MangaSource.fromJson(json.decode(str));

String mangaSourceToJson(MangaSource data) => json.encode(data.toJson());

class MangaSource {
  MangaSource({
    this.sources,
  });

  List<Source> sources;

  factory MangaSource.fromJson(Map<String, dynamic> json) => MangaSource(
    sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
  };
}

class Source {
  Source({
    this.sourceId,
    this.url,
    this.shortName,
  });

  int sourceId;
  String url;
  String shortName;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    sourceId: json["sourceId"],
    url: json["url"],
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "sourceId": sourceId,
    "url": url,
    "shortName": shortName,
  };
}
