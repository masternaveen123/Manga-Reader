// To parse this JSON data, do
//
//     final manga = mangaFromJson(jsonString);

import 'dart:convert';

Manga mangaFromJson(String str) => Manga.fromJson(json.decode(str));

String mangaToJson(Manga data) => json.encode(data.toJson());

class Manga {
  Manga({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.imageUrl,
    this.source,
    this.sourceSpecificName,
    this.currentChapter,
    this.currentChapterUrl,
    this.additionalInfo,
  });

  String title;
  String imageUrl;
  Source source;
  String sourceSpecificName='';
  String currentChapter;
  String currentChapterUrl;
  AdditionalInfo additionalInfo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    imageUrl: json["imageURL"],
    source: sourceValues.map[json["source"]],
    sourceSpecificName: json["sourceSpecificName"],
    currentChapter: json["currentChapter"],
    currentChapterUrl: json["currentChapterURL"],
    additionalInfo: AdditionalInfo.fromJson(json["additionalInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "imageURL": imageUrl,
    "source": sourceValues.reverse[source],
    "sourceSpecificName": sourceSpecificName,
    "currentChapter": currentChapter,
    "currentChapterURL": currentChapterUrl,
    "additionalInfo": additionalInfo.toJson(),
  };
}

class AdditionalInfo {
  AdditionalInfo({
    this.rating,
    this.views,
    this.date,
    this.author,
    this.description,
    this.mangaUrl,
  });

  String rating;
  String views;
  String date;
  String author;
  String description;
  String mangaUrl;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
    rating: json["rating"],
    views: json["views"],
    date: json["date"],
    author: json["author"],
    description: json["description"],
    mangaUrl: json["mangaURL"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "views": views,
    "date": date,
    "author": author,
    "description": description,
    "mangaURL": mangaUrl,
  };
}

enum Source { MANGANELO_COM }

final sourceValues = EnumValues({
  "manganelo.com": Source.MANGANELO_COM
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
