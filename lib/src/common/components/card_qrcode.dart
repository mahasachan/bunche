import 'dart:typed_data';
import 'package:flutter/material.dart';

class CardQrcode extends StatelessWidget {
  const CardQrcode({
    super.key,
    required this.accountName,
    required this.qrCode,
    required this.index,
    this.isEdit = false,
  });

  final String accountName;
  final Uint8List qrCode;
  final int index;
  final bool? isEdit;

  // final void Function(int index) onDeleteQrcode;
  // final FriendViewModel friendViewModel;

  @override
  Widget build(BuildContext context) {
    Widget contentBottom = const SizedBox(height: 40);
    if (isEdit ?? false) {
      contentBottom = ButtonBar(
        alignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              // friendViewmodel.deleteQRCode(index);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    }

    return Column(
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/QrcodeDetail',
                      arguments: [accountName, qrCode]);
                },
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.memory(
                    qrCode,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              contentBottom,
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
