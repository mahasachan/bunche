import 'package:bunche/src/common/constants/hive.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/services/group/group_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GroupService implements GroupServiceInterface {
  Future<Box<Group>> get _groupBox async =>
      await Hive.openBox(groupStoreBoxName);

  @override
  Future<Group> createGroup(Group group) async {
    final box = await _groupBox;
    try {
      await box.put(group.id, group);
      await box.close();
      return group;
    } catch (e) {
      return Future.error('Error creating Group');
    } finally {
      await box.close();
    }
  }

  @override
  Future<bool> deleteGroup(String groupId) async {
    final box = await _groupBox;
    try {
      await box.delete(groupId);
      // await box.close();
      return true;
    } catch (e) {
      return Future.error('Error deleting Group');
    } finally {
      await box.close();
    }
  }

  @override
  Future<Group?> getGroup(String groupId) async {
    final box = await _groupBox;
    try {
      final group = box.get(groupId);
      return group;
    } catch (e) {
      return Future.error('Error getting Group');
    } finally {
      await box.close();
    }
  }

  @override
  Future<List<Group>> getGroups() async {
    final box = await _groupBox;
    try {
      final groups = box.values.toList();
      debugPrint('Groups: ${groups.length}');
      // await box.close();
      return groups;
    } catch (e) {
      return Future.error('Error getting Groups');
    }
  }

  @override
  Future<Group> upDateGroup(Group group) async {
    final box = await _groupBox;
    try {
      await box.put(group.id, group);
      return group;
    } catch (e) {
      return Future.error('Error updating Group');
    } finally {
      await box.close();
    }
  }
}
