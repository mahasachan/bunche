import 'package:bunche/data/datasources/local/hive_qrcode.dart';
// import 'package:bunche/data/models/qrcode.dart';
import 'package:flutter/material.dart';

class QrcodeListPreview extends StatelessWidget {
  const QrcodeListPreview({super.key, required this.qrcodes});
  final List<QRCodeHive> qrcodes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.amberAccent.shade100),
      width: double.infinity,
      height: 300,
      child: ListView.builder(
          itemCount: qrcodes.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(qrcodes[index].accountName),
                Image.memory(
                  qrcodes[index].qrCodeImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ],
            );
          }),
    );
  }
}
