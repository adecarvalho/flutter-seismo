import 'package:flutter/material.dart';

//
class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Seismo',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Application mobile, pour le suivi des tremblements de Terre (> 4.5)',
            style: TextStyle(fontSize: 14),
          ),
          Text('Source: https://earthquake.usgs.gov'),
          Text('Auteur: A.De Carvalho'),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            child: Image(
              image: AssetImage('assets/logo.png'),
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
