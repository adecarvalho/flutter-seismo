import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seismo/components/alert_message.dart';
import 'package:seismo/components/spin_loading.dart';
import 'package:seismo/modele/quake.dart';
import 'package:seismo/store/quake_state.dart';

//
class QuakePage extends StatelessWidget {
  //
  ListView _buildList(context, listquake) {
    return ListView.builder(
      itemCount: listquake.length,
      itemBuilder: (context, indice) {
        return new CardQuake(quake: listquake[indice]);
      },
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Consumer<QuakeState>(
      builder: (context, storelink, child) {
        //
        if (storelink.erreurs != '') {
          return AlertMessage(message: storelink.erreurs);
        }
        //
        return Container(
          child: !storelink.loading
              ? _buildList(context, storelink.getQuakes())
              : SpinLoading(),
        );
      },
    );
  }
}

class CardQuake extends StatelessWidget {
  const CardQuake({
    Key key,
    @required this.quake,
  }) : super(key: key);

  final Quake quake;

  @override
  Widget build(BuildContext context) {
    //
    return Card(
      elevation: 2,
      color: Colors.grey[200],
      //
      child: ListTile(
        onTap: () {
          // print(quake.toString());
          final store = Provider.of<QuakeState>(context, listen: true);
          store.changePointCenter(quake.latitude, quake.longitude);
          store.showMapPage();
        },
        title: Text(
          quake.place,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(quake.getDate()),
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Text(
            '${quake.magnetude}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
