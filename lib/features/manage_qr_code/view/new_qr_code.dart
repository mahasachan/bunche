import 'dart:io';

import 'package:bunche/core/utils/utils.dart';
import 'package:bunche/data/datasources/local/hive_qrcode.dart';
// import 'package:bunche/data/models/qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/image_input.dart';
import 'package:flutter/material.dart';

class NewQRcode extends StatefulWidget {
  const NewQRcode({super.key});

  @override
  State<NewQRcode> createState() => _NewQRcodeState();
}

class _NewQRcodeState extends State<NewQRcode> {
  final _accountNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New QR Code'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an account name';
                }
                return null;
              },
              controller: _accountNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Account Name',
              ),
            ),
            ImageInput(onPickImage: (File image) {
              _selectedImage = image;
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveQRcode();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveQRcode() async {
    if (_selectedImage == null) {
      showSnackbar(context, 'Please select an image');
      return;
    }

    if (context.mounted) {
      Navigator.pop(
        context,
        QRCodeHive(
          accountName: _accountNameController.text,
          qrCodeImage: await convertFileToBytes(_selectedImage!),
        ),
      );
    }
  }
}
