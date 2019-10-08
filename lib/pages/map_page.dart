import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:seismo/components/alert_message.dart';
import 'package:seismo/components/spin_loading.dart';
import 'package:seismo/modele/quake.dart';
import 'package:seismo/store/quake_state.dart';

//
class MapPage extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuakeState>(context, listen: true);

    if (store.erreurs != '') {
      return AlertMessage(message: store.erreurs);
    }

    return Column(
      children: <Widget>[
        Flexible(
          child: !store.loading
              ? MyMap(
                  listquakes: store.getQuakes(),
                )
              : SpinLoading(),
        )
      ],
    );
  }
}

//
class MyMap extends StatelessWidget {
  final List<Quake> listquakes;

  const MyMap({Key key, this.listquakes}) : super(key: key);

//
  Marker _createMarker(Quake quake) {
    return Marker(
      point: LatLng(quake.latitude, quake.longitude),
      width: 40.0,
      height: 40.0,
      builder: (BuildContext context) {
        return Container(
          child: IconButton(
              icon: Icon(Icons.location_on),
              color: Colors.purpleAccent,
              iconSize: 40.0,
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1300),
                    content: ListTile(
                      title: Text(quake.place),
                      subtitle: Text(quake.getDate()),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text(
                          '${quake.magnetude}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

//
  List<Marker> _createMarkersList() {
    List<Marker> mliste = List<Marker>();

    if (listquakes != null) {
      for (Quake item in listquakes) {
        mliste.add(_createMarker(item));
      }
      return mliste;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    //
    return Consumer<QuakeState>(builder: (context, storelink, child) {
      return FlutterMap(
        options: MapOptions(
          center: storelink.pointCenter,
          zoom: 4.0,
          minZoom: 2.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c']),
          //
          MarkerLayerOptions(markers: _createMarkersList())
        ],
      );
    });
  }
}
