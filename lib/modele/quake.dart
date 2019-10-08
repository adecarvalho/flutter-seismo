import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

//
class Quake {
  double _magnetude = 0;
  String _place = '';
  int _time = 0;
  String _title = '';

  double _latitude = 0.0;
  double _longitude = 0.0;

//
  Quake() {}

  Quake.fromJson(Map<String, dynamic> json) {
    this._magnetude = json['magnetude'];
    this._place = json['place'];
    this._time = json['time'];
    this._title = json['title'];
    this._latitude = json['latitude'];
    this._longitude = json['longitude'];
  }

  //
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    //
    data['magnetitude'] = this._magnetude;
    data['place'] = this._place;
    data['time'] = this._time;
    data['title'] = this._title;

    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;

    return data;
  }

//
  double get magnetude => _magnetude;

  set magnetude(double magnetude) {
    _magnetude = magnetude;
  }

//
  String get place => _place;

  set place(String place) {
    _place = place;
  }

//
  int get time => _time;

  set time(int time) {
    _time = time;
  }

//
  String get title => _title;

  set title(String title) {
    _title = title;
  }

//
  double get latitude => _latitude;

  set lattitude(double lattitude) {
    _latitude = lattitude;
  }

//
  double get longitude => _longitude;

  set longitude(double longitude) {
    _longitude = longitude;
  }

//
  String getDate() {
    initializeDateFormatting();
    int cal = this._time;
    DateTime jour = DateTime.fromMillisecondsSinceEpoch(cal);
    Intl.defaultLocale = 'fr_FR';

    return 'le, ${DateFormat("dd-MMMM-yyyy").format(jour)}';
  }

  //
  String toString() {
    return 'Place: $_place Magn:$_magnetude Long:$_longitude Lat:$_longitude';
  }
}
