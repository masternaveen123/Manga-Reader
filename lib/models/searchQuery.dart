// To parse this JSON data, do
//
//     final searchQuery = searchQueryFromJson(jsonString);

import 'dart:convert';

SearchQuery searchQueryFromJson(String str) => SearchQuery.fromJson(json.decode(str));

String searchQueryToJson(SearchQuery data) => json.encode(data.toJson());

class SearchQuery {
  SearchQuery({
    this.success,
    this.data,
  });

  bool success;
  List<SearchQueryData> data;

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
    success: json["success"],
    data: List<SearchQueryData>.from(json["data"].map((x) => SearchQueryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchQueryData {
  SearchQueryData({
    this.title,
    this.sourceSpecificName,
    this.imageUrl,
    this.mangaUrl,
    this.source,
    this.additionalInfo,
  });

  String title;
  String sourceSpecificName;
  String imageUrl;
  String mangaUrl;
  String source;
  AdditionalInfo additionalInfo=null;

  factory SearchQueryData.fromJson(Map<String, dynamic> json) => SearchQueryData(
    title: json["title"],
    sourceSpecificName: json["sourceSpecificName"],
    imageUrl: json["imageURL"],
    mangaUrl: json["mangaURL"],
    source: json["source"],
    additionalInfo: AdditionalInfo.fromJson(json["additionalInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sourceSpecificName": sourceSpecificName,
    "imageURL": imageUrl,
    "mangaURL": mangaUrl,
    "source": source,
    "additionalInfo": additionalInfo.toJson(),
  };
}

class AdditionalInfo {
  AdditionalInfo({
    this.alternateNames,
    this.status,
    this.latestChapter,
    this.author,
    this.synopsis,
    this.id,
    this.lastChapter,
  });

  List<String> alternateNames=[];
  String status;
  String latestChapter;
  List<String> author=[];
  String synopsis;
  String id;
  String lastChapter;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
    alternateNames: json["alternateNames"] == null ? null : List<String>.from(json["alternateNames"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    latestChapter: json["latestChapter"] == null ? null : json["latestChapter"],
    author: json["author"] == null ? null : List<String>.from(json["author"].map((x) => x)),
    synopsis: json["synopsis"] == null ? null : json["synopsis"],
    id: json["id"] == null ? null : json["id"],
    lastChapter: json["lastChapter"] == null ? null : json["lastChapter"],
  );

  Map<String, dynamic> toJson() => {
    "alternateNames": alternateNames == null ? null : List<dynamic>.from(alternateNames.map((x) => x)),
    "status": status == null ? null : status,
    "latestChapter": latestChapter == null ? null : latestChapter,
    "author": author == null ? null : List<dynamic>.from(author.map((x) => x)),
    "synopsis": synopsis == null ? null : synopsis,
    "id": id == null ? null : id,
    "lastChapter": lastChapter == null ? null : lastChapter,
  };
}
