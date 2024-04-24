import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/card_qrcode.dart';
import 'package:flutter/material.dart';

class QrcodeListPreview extends StatelessWidget {
  const QrcodeListPreview({super.key, required this.qrcodes});
  final List<QRCodeHive> qrcodes;

  @override
  Widget build(BuildContext context) {
    // _friendViewModel.qrcodes = qrcodes;
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
          itemCount: qrcodes.length,
          itemBuilder: (context, index) {
            return CardQrcode(
              onEditQrcode: () {},
              accountName: qrcodes[index].accountName,
              qrCode: qrcodes[index].qrCodeImage,
              index: index,
            );
          }),
    );
  }

  void editQrcode(QRCodeHive qrcode) {}
  //
}
