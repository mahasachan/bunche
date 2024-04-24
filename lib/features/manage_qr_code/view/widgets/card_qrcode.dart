import 'dart:typed_data';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardQrcode extends StatelessWidget {
  const CardQrcode({
    super.key,
    required this.accountName,
    required this.qrCode,
    required this.onEditQrcode,
    required this.index,
    // required this.onDeleteQrcode,
  });

  final String accountName;
  final Uint8List qrCode;
  final int index;
  final void Function() onEditQrcode;
  // final void Function(int index) onDeleteQrcode;
  // final FriendViewModel friendViewModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<FriendViewModel>(
      builder: (context, friendViewmodel, child) {
        return Card(
          margin: const EdgeInsets.all(10),
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_drop_down_circle),
                title: Text(accountName),
                subtitle: Text(
                  'Secondary Text',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blue.shade200),
                height: 200,
                width: double.infinity,
                child: Image.memory(
                  qrCode,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Perform some action
                      debugPrint('action edit');
                    },
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint('action delete');
                      friendViewmodel.deleteQRCode(index);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
