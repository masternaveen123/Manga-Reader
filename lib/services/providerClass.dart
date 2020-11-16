import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mangareader/models/manga.dart';
import 'package:http/http.dart' as http;

class ProviderClass extends ChangeNotifier {
  bool isLoading = true;
  Manga _manga = new Manga();
  List<Datum> list = new List();

  ProviderClass() {
    _manga.data = list;
  }

  setData(Manga data) {
    _manga = data;
    isLoading = false;
  }

  Manga getData() {
    return _manga;
  }

  Future<Manga> hitApi() async {
    var response =
        await http.get("https://manganode.herokuapp.com/manga/2/hotupdates");
    final Map parsed = jsonDecode(response.body);
    Manga manga = Manga.fromJson(parsed);
    return manga;
  }
}
