import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'hive_qrcode.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class QRCodeHive {
  @HiveField(0)
  String id;

  @HiveField(1)
  String accountName;

  @HiveField(2)
  Uint8List qrCodeImage;

  QRCodeHive({
    required this.accountName,
    required this.qrCodeImage,
  }) : id = uuid.v4();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountName'] = accountName;
    data['qrCodeImage'] = qrCodeImage;
    return data;
  }

  factory QRCodeHive.fromJson(Map<String, dynamic> json) {
    return QRCodeHive(
      accountName: json['accountName'],
      qrCodeImage: (json['qrCodeImage']),
    );
  }
}
