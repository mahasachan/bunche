// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendAdapter extends TypeAdapter<Friend> {
  @override
  final int typeId = 5;

  @override
  Friend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Friend(
      name: fields[1] as String,
      qrcodeIds: (fields[2] as List?)?.cast<String>(),
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Friend obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.qrcodeIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
