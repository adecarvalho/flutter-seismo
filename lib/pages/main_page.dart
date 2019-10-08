import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seismo/pages/help_page.dart';
import 'package:seismo/pages/map_page.dart';
import 'package:seismo/pages/quake_page.dart';
import 'package:seismo/store/quake_state.dart';

//
class MainPage extends StatelessWidget {
  //
  Future<Null> getQuakeHandler(QuakeState store) async {
    await store.fetchQuakes();
    return Null;
  }

  //
  Widget callPage(int index) {
    switch (index) {
      case QuakeState.SEISME_PAGE:
        return QuakePage();

      case QuakeState.CARTE_PAGE:
        return MapPage();

      case QuakeState.AIDE_PAGE:
        return HelpPage();

      default:
        return QuakePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuakeState>(context, listen: true);
    //
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: store.zeIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text("Seismes"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Carte"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text("Aide"),
          ),
        ],
        onTap: (value) {
          store.changePage(value);
        },
      ),
      appBar: AppBar(
        title: Text("Seismo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              getQuakeHandler(store);
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: callPage(store.zeIndex),
    );
  }
}
