// To parse this JSON data, do
//
//     final searchSource = searchSourceFromJson(jsonString);

import 'dart:convert';

SearchSource searchSourceFromJson(String str) =>
    SearchSource.fromJson(json.decode(str));

String searchSourceToJson(SearchSource data) => json.encode(data.toJson());

class SearchSource {
  SearchSource({
    this.success,
    this.data,
  });

  bool success;
  List<SearchSourceData> data;

  factory SearchSource.fromJson(Map<String, dynamic> json) => SearchSource(
        success: json["success"],
        data: List<SearchSourceData>.from(
            json["data"].map((x) => SearchSourceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchSourceData {
  SearchSourceData({
    this.title,
    this.sourceSpecificName,
    this.imageUrl,
    this.mangaUrl,
    this.source,
    // this.additionalInfo,
  });

  String title;
  String sourceSpecificName;
  String imageUrl;
  String mangaUrl;
  String source;
  // AdditionalInfo additionalInfo;

  factory SearchSourceData.fromJson(Map<String, dynamic> json) =>
      SearchSourceData(
        title: json["title"],
        sourceSpecificName: json["sourceSpecificName"],
        imageUrl: json["imageURL"],
        mangaUrl: json["mangaURL"],
        source: json["source"],
        // additionalInfo: AdditionalInfo.fromJson(json["additionalInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sourceSpecificName": sourceSpecificName,
        "imageURL": imageUrl,
        "mangaURL": mangaUrl,
        "source": source,
        // "additionalInfo": additionalInfo.toJson(),
      };
}

class AdditionalInfo {
  AdditionalInfo({
    this.alternateNames,
  });

  List<String> alternateNames;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        alternateNames: List<String>.from(json["alternateNames"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "alternateNames": List<dynamic>.from(alternateNames.map((x) => x)),
      };
}
