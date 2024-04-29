import 'dart:typed_data';

// import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:flutter/material.dart';

class QrcodeDetailView extends StatelessWidget {
  const QrcodeDetailView({
    super.key,
    required this.accountName,
    required this.qrCodeImage,
    // required this.qrcodeInstance
  });
  // final QRCode qrcodeInstance;
  final String accountName;
  final Uint8List qrCodeImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.memory(
                // qrcodeInstance.qrCodeImage,
                qrCodeImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(accountName),
    );
  }
}
