import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/card_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
// import 'package:bunche/data/models/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QrcodeListPreview extends StatelessWidget {
  const QrcodeListPreview({super.key, required this.qrcodes});
  final List<QRCodeHive> qrcodes;

  @override
  Widget build(BuildContext context) {
    // _friendViewModel.qrcodes = qrcodes;
    return Consumer<FriendViewModel>(
      builder: (context, FriendViewModel friendViewModel, child) {
        return SizedBox(
          // decoration: BoxDecoration(color: Colors.amberAccent.shade100),
          width: double.infinity,
          // height: 300,
          child: ListView.builder(
              itemCount: friendViewModel.qrcodes.length,
              itemBuilder: (context, index) {
                return CardQrcode(
                  onEditQrcode: () {},
                  accountName: qrcodes[index].accountName,
                  qrCode: friendViewModel.qrcodes[index].qrCodeImage,
                  index: index,
                );
              }),
        );
      },
    );
  }

  void editQrcode(QRCodeHive qrcode) {}
  //
}
