import 'package:bunche/data/datasources/local/hive_group.dart';
import 'package:bunche/features/manage_qr_code/respository/group_repository.dart';

class GroupService {
  final GroupRepository _groupRepository;

  GroupService(this._groupRepository);

  Future<List<GroupHive>> getAllGroups() async {
    List<GroupHive> groups = await _groupRepository.getGroups();
    return groups;
  }

  Future<GroupHive?> getGroup(int index) async {
    GroupHive? group = await _groupRepository.getGroup(index);
    if (group == null) return null;
    return group;
  }

  Future<int> addGroup(GroupHive group) async {
    final int indexAdded = await _groupRepository.createGroup(group);
    return indexAdded;
  }

  Future<void> updateGroup(GroupHive group, int index) async {
    await _groupRepository.updateGroup(group, index);
  }

  Future<void> deleteGroup(int index) async {
    await _groupRepository.deleteGroup(index);
  }
}
