import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:seismo/modele/quake.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuakeState with ChangeNotifier {
  static const int SEISME_PAGE = 0;
  static const int CARTE_PAGE = 1;
  static const int AIDE_PAGE = 2;
  //
  List<Quake> _quakesList = List<Quake>();

  String _erreurs = '';

  bool loading = false;

  int _zeIndex = 0;

  LatLng _pointCenter = LatLng(0, 0);

  QuakeState() {
    firstFetch();
  }

  //
  Future<Null> firstFetch() async {
    await fetchQuakes();
  }

  int get zeIndex => this._zeIndex;

  String get erreurs => this._erreurs;

  LatLng get pointCenter => this._pointCenter;

  //
  void showMapPage() {
    this._zeIndex = 1;
    notifyListeners();
  }

  //
  void changePointCenter(double lat, double lon) {
    this._pointCenter = LatLng(lat, lon);
    notifyListeners();
  }

  //
  void changePage(int val) {
    this._zeIndex = val;
    notifyListeners();
  }

  //
  List<Quake> getQuakes() {
    return _quakesList;
  }

  Future startLoading() async {
    this.loading = true;
    notifyListeners();

    await Future.delayed(
      Duration(seconds: 1),
    );
  }

  //
  Future<void> fetchQuakes() async {
    try {
      final url =
          'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson';

      //
      await startLoading();
      //
      http.Response response = await http.get(url);
      List datas = jsonDecode(response.body)['features'];

      for (var i = 0; i < datas.length; i++) {
        Map<String, dynamic> map = Map();
        map['place'] = datas[i]['properties']["place"];
        map['magnetude'] = datas[i]['properties']["mag"] * 1.0;
        map['time'] = datas[i]['properties']["time"];
        map['title'] = datas[i]['properties']["title"];
        map['longitude'] = datas[i]['geometry']["coordinates"][0];
        map['latitude'] = datas[i]['geometry']["coordinates"][1];

        _quakesList.add(Quake.fromJson(map));
        _quakesList.sort((a, b) => b.magnetude.compareTo(a.magnetude));
      }
      //
      loading = false;
      _erreurs = '';
      notifyListeners();
      //
    } catch (e) {
      print(e);
      _erreurs = e.toString();
      this.loading = false;
      notifyListeners();
    }
  }
}
