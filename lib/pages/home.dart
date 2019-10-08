//pk.eyJ1IjoiYWRlbGluby1kZWNhcnZhbGhvIiwiYSI6ImNrMHl6eXp5ZDA5ZWQzbm83czZoaTF4NWMifQ.l7LyJhX0SfIS5NbxRSpT2g

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

//
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seismo'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: new MyMap(),
          )
        ],
      ),
    );
  }
}

//
class MyMap extends StatelessWidget {
  const MyMap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    CircleMarker circle = CircleMarker(
        point: LatLng(48.8, 2.3),
        color: Colors.red.withOpacity(0.7),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: 2000 // 2000 meters | 2 km
        );
    //
    Marker posiMarkers = Marker(
        point: LatLng(48.866667, 2.333333),
        width: 40.0,
        height: 40.0,
        builder: (ctx) {
          return Container(
            child: GestureDetector(
              onTap: () {
                print('action');
              },
              child: IconButton(
                icon: Icon(Icons.location_on),
                iconSize: 40,
                color: Colors.blue,
                onPressed: () {
                  print('essai');
                },
              ),
            ),
          );
        });

    //
    return FlutterMap(
      options: MapOptions(
        center: LatLng(48.866667, 2.333333),
        zoom: 5.0,
        //minZoom: 10.0,
        maxZoom: 10,
        /* onTap: (latlon) {
            print(latlon);
          }), */
      ),
      layers: [
        //
        //TileLayerOptions(
        // urlTemplate:
        //   'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
        //),
        //
        /*
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={pk.eyJ1IjoiYWRlbGluby1kZWNhcnZhbGhvIiwiYSI6ImNrMHl6eXp5ZDA5ZWQzbm83czZoaTF4NWMifQ.l7LyJhX0SfIS5NbxRSpT2g}",
          additionalOptions: {
            'accessToken':
                '<pk.eyJ1IjoiYWRlbGluby1kZWNhcnZhbGhvIiwiYSI6ImNrMHl6eXp5ZDA5ZWQzbm83czZoaTF4NWMifQ.l7LyJhX0SfIS5NbxRSpT2g>',
            'id': 'mapbox.streets',
          },
          
        ),
        */
        //
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        //
        MarkerLayerOptions(markers: [
          posiMarkers,
        ]),
        //
        CircleLayerOptions(circles: [
          circle,
        ])
      ],
    );
  }
}
