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

  Future<void> tryAddQrcode(QRCode qrcode) async {
    await _qrcodeService.createQRcode(qrcode);
    _qrcodes.add(qrcode);
    await tryToFetchQrcodes();
    notifyListeners();
  }

  Future<void> tryRemoveQrcode(String qrcodeId) async {
    await tryToFetchQrcodes();
    if (_qrcodes.isEmpty) return;
    final qrcodeTarget = await _qrcodeService.getQRcode(qrcodeId);
    await _qrcodeService.deleteQRcode(qrcodeTarget);
    tryToFetchQrcodes();
    _qrcodes.remove(qrcodeTarget);
    notifyListeners();
  }

  Future<void> tryToFetchQrcodes() async {
    final allQrcodes = await _qrcodeService.getQrcodes();
    _qrcodes = [];
    for (final qrcode in allQrcodes) {
      _qrcodes.add(qrcode);
    }
    notifyListeners();
  }

  Future<QRCode> tryToFetchQrcode(String qrcodeId) async {
    final qrcode = await _qrcodeService.getQRcode(qrcodeId);
    return qrcode;
  }
}
