import 'package:bunche/src/data/models/group/group.dart';

abstract class GroupServiceInterface {
  Future<List<Group>> getGroups();
  Future<Group?> getGroup(String groupId);
  Future<bool> deleteGroup(String groupId);
  Future<Group> upDateGroup(Group group);
  Future<Group> createGroup(Group group);
}
