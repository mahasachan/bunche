import 'dart:io';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/helper.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';

class QrcodeCreateViewModel {
  final accountNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final NavigationService _navigationService;

  // QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  QrcodeList qrcodeList = QrcodeList();
  File? selectedImage;

  QrcodeCreateViewModel(this._navigationService);

  void onSaveQRcode() async {
    if (selectedImage == null) {
      _navigationService.showSnackBar('Please select an image');
      return;
    }
    final newQRcode = QRCode(
      accountName: accountNameController.text,
      qrCodeImage: await convertFileToBytes(selectedImage!),
    );
    _navigationService.nvigateBackWithData(newQRcode);
  }

  void tryToFetchQrcode(String qrcodeId) async {
    await qrcodeList.tryToFetchQrcode(qrcodeId);
  }

  void dispose() {
    accountNameController.dispose();
  }
}
