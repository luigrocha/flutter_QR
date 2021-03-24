import 'package:flutter/material.dart';
import 'package:qr/src/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [],
      ),
      body: Center(
        child: Text(scan.valor),
      ),
    );
  }
}
