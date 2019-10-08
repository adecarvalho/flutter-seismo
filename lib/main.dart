import 'package:flutter/material.dart';
import 'package:seismo/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:seismo/store/quake_state.dart';

void main() => runApp(SeismoApp());

class SeismoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => QuakeState(),
        ),
      ],
      child: MaterialApp(
        title: 'Seismo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
            color: Colors.purpleAccent,
          ),
        ),
        home: MainPage(),
      ),
    );
  }
}
