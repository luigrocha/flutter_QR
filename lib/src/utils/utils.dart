import 'package:flutter/material.dart';
import 'package:qr/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(ScanModel scan, BuildContext context) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  } else {
    print('geo!!!');
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
