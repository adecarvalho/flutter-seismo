import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final String message;

  AlertMessage({this.message});

  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Alerte',
            style: TextStyle(
              fontSize: 35,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(this.message, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
