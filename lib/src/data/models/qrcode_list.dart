import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/services/qrcode/qrcode_service.dart';
import 'package:flutter/material.dart';

class QrcodeList extends ChangeNotifier {
  final QrcodeService _qrcodeService = QrcodeService();

  List<QRCode> _qrcodes = [];
  List<QRCode> get qrcodes => _qrcodes;

  QrcodeList() {
    tryToFetchQrcodes();
  }

  void tryAddQrcode(QRCode qrcode) {
    qrcode.tryAddQrcode(qrcode);
    _qrcodes.add(qrcode);
    _qrcodeService.createQRcode(qrcode);
    notifyListeners();
  }

  Future<void> tryRemoveQrcode(String qrcodeId) async {
    final qrcodeTarget = _qrcodes.firstWhere((qrcode) => qrcode.id == qrcodeId);
    qrcodes.remove(qrcodeTarget);
    await _qrcodeService.deleteQRcode(qrcodeId);
    notifyListeners();
  }

  void tryToFetchQrcodes() async {
    _qrcodes = await _qrcodeService.getQrcodes();
    notifyListeners();
  }

  Future<QRCode> tryToFetchQrcode(String qrcodeId) async {
    final qrcode = await _qrcodeService.getQRcode(qrcodeId);
    return qrcode;
  }
}
