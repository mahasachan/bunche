import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'qrcode.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class QRCode {
  @HiveField(0)
  String id;

  @HiveField(1)
  String accountName;

  @HiveField(2)
  Uint8List qrCodeImage;

  @HiveField(3)
  String? groupId;

  QRCode({
    required this.accountName,
    required this.qrCodeImage,
    this.groupId,
  }) : id = uuid.v4();

  void tryAddQrcode(QRCode qrcode) {
    accountName = qrcode.accountName;
    qrCodeImage = qrcode.qrCodeImage;
    if (groupId != null) {
      groupId = qrcode.groupId;
    }
  }

  void tryUpdateQrcode(String newAccountName, Uint8List newQrCodeImage) {
    accountName = newAccountName;
    qrCodeImage = newQrCodeImage;
  }

  void tryRemoveQrcode(String qrcode) {}

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['accountName'] = accountName;
  //   data['qrCodeImage'] = qrCodeImage;
  //   return data;
  // }

  // factory QRCode.fromJson(Map<String, dynamic> json) {
  //   return QRCode(
  //     accountName: json['accountName'],
  //     qrCodeImage: (json['qrCodeImage']),
  //   );
  // }
}
