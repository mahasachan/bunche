import 'package:bunche/data/models/qrcode.dart';

abstract class QRCodeRepository {
  Future<QRCode> getQRCode(String id);
  Future<List<QRCode>> getQRCodeList();
  Future<void> addQRCode(QRCode qrCode);
  Future<void> updateQRCode(QRCode qrCode);
  Future<void> deleteQRCode(String id);
}
