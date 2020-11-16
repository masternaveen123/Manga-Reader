import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mangareader/models/chapters.dart';
import 'package:mangareader/models/manga.dart';

class APIHotUp {
  var source;
  APIHotUp(this.source);

  Future<Manga> getManga() async {
    var client = http.Client();

    var mangaModel = null;
    try {
      var response = await client
          .get('https://manganode.herokuapp.com/manga/$source/hotupdates');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = Manga.fromJson(jsonMap);
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }

    return mangaModel;
  }
}

class APILatestUp {
  var source;
  APILatestUp(this.source);

  Future<Manga> getManga() async {
    var client = http.Client();

    var mangaModel = null;
    try {
      var response = await client
          .get('https://manganode.herokuapp.com/manga/$source/latestupdates');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = Manga.fromJson(jsonMap);
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }

    return mangaModel;
  }
}

class APIChapters {
  var source;
  var chapter;
  APIChapters({this.source,this.chapter});

  Future<Chapter> getChapter() async {
    var client = http.Client();

    var mangaModel = null;
    try {
      var response = await client
          .get('https://manganode.herokuapp.com/manga/$source/chapters/$chapter');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = Chapter.fromJson(jsonMap);
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }

    return mangaModel;
  }
}
