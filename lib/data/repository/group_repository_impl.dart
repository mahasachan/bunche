import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/data/datasources/local/hive_group.dart';
import 'package:bunche/features/manage_qr_code/respository/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GroupRepositoryImpl implements GroupRepository {
  final String _groupBoxName = 'groups';
  Future<Box<GroupHive>> get _groupBox async =>
      await Hive.openBox(_groupBoxName);

  @override
  Future<void> clearGroups() {
    throw UnimplementedError();
  }

  @override
  Future<int> createGroup(GroupHive group) async {
    try {
      final box = await _groupBox;
      // await box.put(group.id, group);
      final int indexAdd = await box.add(group);
      return indexAdd;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  @override
  Future<bool> deleteGroup(int index) async {
    try {
      final box = await _groupBox;
      await box.deleteAt(index);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<GroupHive?> getGroup(int index) async {
    try {
      final box = await _groupBox;
      return box.getAt(index);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<List<GroupHive>> getGroups() async {
    try {
      final box = await _groupBox;
      return box.values.toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<bool> isGroupExist(String id) async {
    try {
      final box = await _groupBox;
      return box.containsKey(id);
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<void> updateGroup(GroupHive group, int index) async {
    try {
      final box = await _groupBox;
      await box.putAt(index, group);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> addFriendToGroup(int groupIndex, int friendIndex) async {
    try {
      final box = await _groupBox;
      final group = box.getAt(groupIndex);
      // final boxFriend
      final friend = box.getAt(friendIndex);
      // group!.friends?.add(friend!);
      // await box.putAt(groupIndex, group);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
