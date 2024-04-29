import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'friend.g.dart';

const uuid = Uuid();

@HiveType(typeId: 5)
class Friend {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String>? qrcodeIds;

  Friend({
    required this.name,
    this.qrcodeIds,
  }) : id = uuid.v4();

  Friend copyWith({
    String? name,
    List<String>? qrcodeIds,
  }) =>
      Friend(
        name: name ?? this.name,
        qrcodeIds: qrcodeIds ?? this.qrcodeIds,
      );

  void tryToAddFriend(Friend friend) {
    name = friend.name;
    qrcodeIds = friend.qrcodeIds;
  }

  void tryToUpdateFriend(String newName, List<String>? newQrcodesId) {
    name = newName;
    // tryToAddQrcodeId(newQrcodeId);
    // qrcodeIds = newQrcodesId;
    debugPrint('in tryToUpdateFriend in friend.dart');
    debugPrint('qrcodeIds: $qrcodeIds');
    // if (!qrcodeIds!.contains(newQrcodeId)) qrcodeIds!.add(newQrcodeId);
  }

  void tryToAddQrcodeId(String qrcodeId) {
    qrcodeIds ??= [];
    if (!qrcodeIds!.contains(qrcodeId)) qrcodeIds!.add(qrcodeId);
  }

  void tryToRemoveQrcodeId(String qrcodeId) {
    if (qrcodeIds == null || qrcodeIds!.isEmpty) return;
    if (qrcodeIds!.contains(qrcodeId)) qrcodeIds!.remove(qrcodeId);
  }
}
