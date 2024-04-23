import 'package:bunche/data/models/qrcode.dart';
import 'package:bunche/features/manage_qr_code/respository/qrcode_repository.dart';

class QRCodeRepositoryImpl implements QRCodeRepository {
  @override
  Future<void> addQRCode(QRCode qrCode) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteQRCode(String id) {
    throw UnimplementedError();
  }

  @override
  Future<QRCode> getQRCode(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<QRCode>> getQRCodeList() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateQRCode(QRCode qrCode) {
    throw UnimplementedError();
  }
}
