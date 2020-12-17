// To parse this JSON data, do
//
//     final images = imagesFromJson(jsonString);

import 'dart:convert';

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.success,
    this.data,
  });

  bool success;
  ImageData data;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    success: json["success"],
    data: ImageData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class ImageData {
  ImageData({
    this.imageUrl,
    this.chapterNumber,
    this.nextChapter,
    this.previousChapter,
    this.mangaTitle,
  });

  Map<String, String> imageUrl;
  String chapterNumber;
  String nextChapter;
  String previousChapter;
  dynamic mangaTitle;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    imageUrl: Map.from(json["imageURL"]).map((k, v) => MapEntry<String, String>(k, v)),
    chapterNumber: json["chapterNumber"],
    nextChapter: json["nextChapter"],
    previousChapter: json["previousChapter"],
    mangaTitle: json["mangaTitle"],
  );

  Map<String, dynamic> toJson() => {
    "imageURL": Map.from(imageUrl).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "chapterNumber": chapterNumber,
    "nextChapter": nextChapter,
    "previousChapter": previousChapter,
    "mangaTitle": mangaTitle,
  };
}
