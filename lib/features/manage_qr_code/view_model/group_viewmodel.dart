import 'package:bunche/core/services/group_service.dart';
import 'package:bunche/core/services/navigator.dart';
import 'package:bunche/data/datasources/local/hive_group.dart';
import 'package:bunche/data/repository/group_repository_impl.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends ChangeNotifier {
  final GroupService _groupService = GroupService(GroupRepositoryImpl());
  final NavigationService _navigationService;

  final List<String> _groupNames = ['No Group'];
  List<String> get groupNames => _groupNames;

  String _selectedGroupName = 'No Group';
  String get selectedGroupName => _selectedGroupName;

  final TextEditingController groupNameController = TextEditingController();

  GroupViewModel(this._navigationService) {
    fetchGroups();
    _selectedGroupName = _groupNames[0];
  }

  Future<void> fetchGroups() async {
    final List<GroupHive> grouphive = await _groupService.getAllGroups();
    for (final group in grouphive) {
      _groupNames.add(group.groupName);
    }
    notifyListeners();
  }

  Future<void> setGroupName(String groupName) async {
    _selectedGroupName = groupName;
    notifyListeners();
  }

  Future<void> addGroupName() async {
    final newGroupName = groupNameController.text.trim();

    if (newGroupName.isEmpty) {
      _navigationService.showSnackBar('Group name cannot be empty');
      return;
    }
    groupNameController.clear();

    if (_groupNames.contains(newGroupName)) {
      _navigationService.showSnackBar('Group name already exists');
      return;
    }

    final GroupHive newGroupHiveName = GroupHive(groupName: newGroupName);
    await _groupService.addGroup(newGroupHiveName);

    _groupNames.add(newGroupName);
    _selectedGroupName = newGroupName;
    notifyListeners();
    _navigationService.goBack();
    _navigationService.showSnackBar('Group name added successfully');
  }
}
