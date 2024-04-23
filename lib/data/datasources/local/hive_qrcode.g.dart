// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_qrcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRCodeHiveAdapter extends TypeAdapter<QRCodeHive> {
  @override
  final int typeId = 0;

  @override
  QRCodeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QRCodeHive(
      accountName: fields[1] as String,
      qrCodeImage: fields[2] as Uint8List,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, QRCodeHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountName)
      ..writeByte(2)
      ..write(obj.qrCodeImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRCodeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
