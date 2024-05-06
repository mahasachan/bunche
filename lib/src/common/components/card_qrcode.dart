import 'dart:typed_data';
import 'package:flutter/material.dart';

class CardQrcode extends StatelessWidget {
  const CardQrcode({
    super.key,
    required this.accountName,
    required this.qrCode,
    required this.index,
    this.isEdit = false,
    // required this.deleteQRCode,
    // this.tryToRemoveQrcode,
    // required this.qrcodeId,
  });

  final String accountName;
  final Uint8List qrCode;
  final int index;
  final bool? isEdit;
  // final String qrcodeId;
  // final void Function(int index)? deleteQRCode;
  // final void Function(String qrcodeId)? tryToRemoveQrcode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: Column(
              children: [
                ListTile(
                  title: Text(accountName),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.memory(
                    qrCode,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // _buildButtonModify()
                const SizedBox(height: 30)
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  ButtonBar _buildButtonModify() {
    return ButtonBar(
      alignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
