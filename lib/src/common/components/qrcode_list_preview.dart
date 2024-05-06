import 'package:bunche/src/common/components/card_qrcode.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:flutter/material.dart';

class QrcodeListPreview extends StatelessWidget {
  const QrcodeListPreview({
    super.key,
    required this.qrcodes,
    this.isEdit,
  });

  final bool? isEdit;
  final List<QRCode> qrcodes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              // deleteQRCode: (int index) {},
            );
          }),
    );
  }
}
