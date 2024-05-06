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

  // @HiveField(3)
  // List<String>? groupIds;

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
    qrcodeIds = newQrcodesId;
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
