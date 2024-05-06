import 'package:bunche/src/common/constants/hive.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/services/qrcode/qrcode_service_interface.dart';
import 'package:hive/hive.dart';

class QrcodeService implements QrcodeServiceInterface {
  Future<Box<QRCode>> get _qrCodeBox async =>
      await Hive.openBox(qrCodeStoreBoxName);

  @override
  Future<String> createQRcode(QRCode qrCode) async {
    final box = await _qrCodeBox;
    try {
      await box.put(qrCode.id, qrCode);
      await box.close();
      return qrCode.id;
    } catch (e) {
      return Future.error('Error creating QRCode');
    }
  }

  @override
  Future<bool> deleteQRcode(QRCode qrcode) async {
    final box = await _qrCodeBox;
    try {
      await box.delete(qrcode.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<QRCode> getQRcode(String qrCodeId) async {
    final box = await _qrCodeBox;
    QRCode? qrCode;
    try {
      qrCode = box.get(qrCodeId);
      return qrCode!;
    } catch (e) {
      return Future.error('Error getting QRCode');
    }
  }

  @override
  Future<List<QRCode>> getQrcodes() async {
    final box = await _qrCodeBox;
    return box.values.toList();
  }

  @override
  Future<QRCode> upDateQRcode(QRCode qrCode, int index) async {
    final box = await _qrCodeBox;
    try {
      await box.putAt(index, qrCode);
      // debugPrint('upDateQRcode: ${qrCode.id}');
      return qrCode;
    } catch (e) {
      return Future.error('Error updating QRCode');
    }
  }
}
