import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mangareader/models/chapters.dart';
import 'package:mangareader/models/images.dart';
import 'package:mangareader/models/manga.dart';
import 'package:mangareader/models/mangaSource.dart';
import 'package:mangareader/models/searchQuery.dart';
import 'package:mangareader/models/searchSource.dart';
import 'package:mangareader/services/constants.dart';

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
  APIChapters({this.source, this.chapter});

  Future<Chapter> getChapter() async {
    var client = http.Client();

    var mangaModel = null;
    try {
      var response = await client.get(
          'https://manganode.herokuapp.com/manga/$source/chapters/$chapter');
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

class APIImages {
  var source;
  var link;
  APIImages({this.source, this.link});

  Future<Images> getImages() async {
    var client = http.Client();

    var mangaModel = null;

    try {
      // print('https://manganode.herokuapp.com/manga/$source/mangadata?chapterURL=$link');
      var response = await client.get(
          'https://manganode.herokuapp.com/manga/$source/mangadata?chapterURL=$link');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = Images.fromJson(jsonMap);
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }

    return mangaModel;
  }
}

class APISearchSource {
  var source;
  // var link;
  APISearchSource({
    this.source,
    // this.link,
  });

  Future<SearchSource> getData() async {
    var client = http.Client();

    var mangaModel = null;

    try {
      print('https://manganode.herokuapp.com/manga/$source/getall');
      var response = await client
          .get('https://manganode.herokuapp.com/manga/$source/getall');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = SearchSource.fromJson(jsonMap);
        print('$source done');
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }

    return mangaModel;
  }
}

class APISearchQuery {
  var source;
  var query;
  // var link;
  APISearchQuery({this.source, this.query
      // this.link,
      });

  Future<SearchQuery> getData() async {
    print("Start");
    var client = http.Client();

    var mangaModel = null;

    try {
      print(
          'https://manganode.herokuapp.com/manga/$source/search/?keyWord=$query');
      var response = await client.get(
          'https://manganode.herokuapp.com/manga/$source/search/?keyWord=${query}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mangaModel = SearchQuery.fromJson(jsonMap);
        print('$source query done , ${mangaModel.toString()}');
      }
    } catch (err) {
      print("Error searchquery is ${err.toString()}");
      return mangaModel;
    }
    print("Done");
    return mangaModel;
  }
}

class APIMangaSource {
  Future<MangaSource> getSources() async {
    var client = http.Client();

    var mangaModel = null;

    try {
      // print('${Constants.api}');
      var response = await client.get('${Constants.api}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = response.body;
        // print(jsonString.toString());
        var jsonMap = jsonDecode(jsonString);
        mangaModel = MangaSource.fromJson(jsonMap);
      }
    } catch (err) {
      print("Error is ${err.toString()}");
      return mangaModel;
    }
    return mangaModel;
  }
}
