import 'package:bunche/data/datasources/local/hive_group.dart';

abstract class GroupRepository {
  Future<List<GroupHive>> getGroups();
  Future<int> createGroup(GroupHive group);
  Future<void> updateGroup(GroupHive group, int index);
  Future<bool> deleteGroup(int index);
  Future<GroupHive?> getGroup(int index);
  Future<bool> isGroupExist(String id);
  Future<void> clearGroups();
  Future<void> addFriendToGroup(int groupIndex, int friendIndex);
}
