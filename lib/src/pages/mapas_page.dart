import 'package:flutter/material.dart';
import 'package:qr/src/widgets/scan_list.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanList(tipo: 'http');
  }
}
