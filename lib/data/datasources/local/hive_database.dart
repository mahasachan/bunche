// import 'dart:io';

// import 'package:bunche/data/models/friend.dart';

import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'hive_database.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class FriendHive {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? groupId;

  @HiveField(3)
  String? groupName;

  @HiveField(4)
  List<QRCodeHive> qrCodes;
  FriendHive({
    required this.name,
    this.groupId,
    this.groupName,
    required this.qrCodes,
  }) : id = uuid.v4();
}
