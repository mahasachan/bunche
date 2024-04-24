// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendHiveAdapter extends TypeAdapter<FriendHive> {
  @override
  final int typeId = 1;

  @override
  FriendHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendHive(
      name: fields[1] as String,
      groupId: fields[2] as String?,
      groupName: (fields[3] as List?)?.cast<String>(),
      qrCodes: (fields[4] as List).cast<QRCodeHive>(),
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, FriendHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.groupId)
      ..writeByte(3)
      ..write(obj.groupName)
      ..writeByte(4)
      ..write(obj.qrCodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
