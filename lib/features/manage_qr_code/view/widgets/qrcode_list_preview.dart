import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/card_qrcode.dart';
import 'package:flutter/material.dart';

class QrcodeListPreview extends StatelessWidget {
  const QrcodeListPreview({super.key, required this.qrcodes, this.isEdit});
  final List<QRCodeHive> qrcodes;
  final bool? isEdit;

  @override
  Widget build(BuildContext context) {
    // _friendViewModel.qrcodes = qrcodes;
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: ListView.builder(
          itemCount: qrcodes.length,
          itemBuilder: (context, index) {
            if (qrcodes.isEmpty) {
              return const Center(
                child: Text('No QR Codes'),
              );
            }
            return CardQrcode(
              isEdit: isEdit,
              accountName: qrcodes[index].accountName,
              qrCode: qrcodes[index].qrCodeImage,
              index: index,
            );
          }),
    );
  }
}
