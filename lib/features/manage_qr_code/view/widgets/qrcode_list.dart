import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:flutter/material.dart';
// import 'package:bunche/data/models/qrcode.dart';

class QrcodeList extends StatefulWidget {
  const QrcodeList({super.key});

  @override
  State<QrcodeList> createState() => _QrcodeListState();
}

class _QrcodeListState extends State<QrcodeList> {
  final List<QRCodeHive> _qrcodes = [];
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
        child: Text('Not have qrcodes click buttom add to create'));
    if (_qrcodes.isNotEmpty) {
      content = ListView.builder(
        itemCount: _qrcodes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Text(_qrcodes[index].accountName),
          );
        },
      );
    }
    return content;
  }
}
