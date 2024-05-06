import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// part '../../../../data/datasources/local/hive_group.g.dart';
part 'group.g.dart';

const uuid = Uuid();

@HiveType(typeId: 4)
class Group {
  @HiveField(0)
  String id;

  @HiveField(1)
  String groupName;

  @HiveField(2)
  List<String>? friendIds;

  Group({
    required this.groupName,
    this.friendIds,
  }) : id = uuid.v4();

  void tryToAddGroup(Group group) {
    groupName = group.groupName;
    friendIds ??= [];
    friendIds = group.friendIds;
  }

  void tryToAddFriend(Group group, String friendId) {
    friendIds ??= [];
    friendIds?.add(friendId);
  }

  void tryToUpdateGroup(List<String> friendIds, String groupName) {
    this.friendIds = [];
    if (friendIds.isEmpty) return;
    for (final friendId in friendIds) {
      this.friendIds?.add(friendId);
    }
    this.groupName = groupName;
  }

  void tryToRemoveGroup() {}

  void tryToRemoveFriend(Group group, String friendId) {
    if (friendIds == null || friendIds!.isEmpty) return;
    if (friendIds!.contains(friendId)) friendIds!.remove(friendId);
  }

  List<String>? tryToFetchFriendIds(Group group) {
    friendIds = group.friendIds;
    if (friendIds == null) return null;
    return friendIds;
  }
}
