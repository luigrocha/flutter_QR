import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/src/pages/direcciones_page.dart';
import 'package:qr/src/pages/mapas_page.dart';
import 'package:qr/src/providers/db_provider.dart';
import 'package:qr/src/providers/ui_provider.dart';
import 'package:qr/src/widgets/custom_navigatorbar.dart';
import 'package:qr/src/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el selected menu

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    // llamar a bd
    final tempScan = new ScanModel(valor: 'http://www.crsoft.org');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScandById(8).then((scan) => print(scan.valor));
    DBProvider.db.getAllScand().then(print);
    switch (currentIndex) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
