import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//
class SpinLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRipple(
        color: Colors.purple,
        size: 150.0,
      ),
    );
    ;
  }
}
