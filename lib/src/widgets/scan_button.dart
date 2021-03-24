import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr/src/providers/scan_list_provider.dart';
import 'package:qr/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // final barcodeScanRes = 'https://www.google.com';
        // final barcodeScanRes = 'https://www.google.com';
        final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3d8bef', 'Cancelar', true, ScanMode.QR);

        if (barcodeScanRes == '-1') return;
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(nuevoScan, context);
      },
    );
  }
}
