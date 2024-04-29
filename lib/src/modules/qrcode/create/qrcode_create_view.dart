import 'dart:io';
import 'package:bunche/src/common/components/image_input.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/modules/qrcode/create/qrcode_create_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QrcodeCreateView extends StatefulWidget {
  const QrcodeCreateView({super.key});

  @override
  State<QrcodeCreateView> createState() => _QrcodeCreateView();
}

class _QrcodeCreateView extends State<QrcodeCreateView> {
  QrcodeCreateViewModel qrcodeCreateViewModel =
      QrcodeCreateViewModel(NavigationService.instance);

  @override
  void dispose() {
    super.dispose();
    qrcodeCreateViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody(context));
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text('New QR Code'),
    );
  }

  _buildBody(BuildContext context) {
    // QrcodeList qrcodeList = context.watch<QrcodeList>();
    // qrcodeCreateViewModel.qrcodeList = qrcodeList;
    return Consumer<QrcodeList>(
      builder: (_, QrcodeList viewmodel, __) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: qrcodeCreateViewModel.formKey,
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
                  controller: qrcodeCreateViewModel.accountNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account Name',
                  ),
                ),
                ImageInput(onPickImage: (File image) {
                  qrcodeCreateViewModel.selectedImage = image;
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (qrcodeCreateViewModel.formKey.currentState!
                        .validate()) {
                      qrcodeCreateViewModel.onSaveQRcode();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
