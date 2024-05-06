import 'package:bunche/src/data/models/qrcode/qrcode.dart';

abstract class QrcodeServiceInterface {
  Future<List<QRCode>> getQrcodes();
  Future<QRCode> getQRcode(String qrCodeId);
  Future<String> createQRcode(QRCode qrCode);
  Future<bool> deleteQRcode(QRCode qrcode);
  Future<QRCode> upDateQRcode(QRCode qrCode, int index);
}
