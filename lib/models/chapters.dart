// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));

String chapterToJson(Chapter data) => json.encode(data.toJson());

class Chapter {
  Chapter({
    this.success,
    this.data,
  });

  bool success;
  List<ChapterData> data;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    success: json["success"],
    data: List<ChapterData>.from(json["data"].map((x) => ChapterData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ChapterData {
  ChapterData({
    this.chapterNumber,
    this.chapterName,
    this.link,
    this.type,
    this.date,
  });

  String chapterNumber;
  String chapterName;
  String link;
  dynamic type;
  String date;

  factory ChapterData.fromJson(Map<String, dynamic> json) => ChapterData(
    chapterNumber: json["chapterNumber"],
    chapterName: json["chapterName"],
    link: json["link"],
    type: json["type"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "chapterNumber": chapterNumber,
    "chapterName": chapterName,
    "link": link,
    "type": type,
    "date": date,
  };
}
