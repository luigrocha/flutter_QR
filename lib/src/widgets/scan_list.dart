import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/src/providers/scan_list_provider.dart';

class ScanList extends StatelessWidget {
  final String tipo;

  const ScanList({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) {
                scanListProvider.borrarScanPorId(scans[i].id);
              },
              child: ListTile(
                leading: Icon(
                    this.tipo == 'http' ? Icons.directions : Icons.map,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.green,
                ),
                onTap: () => {},
              ),
            ));
  }
}
