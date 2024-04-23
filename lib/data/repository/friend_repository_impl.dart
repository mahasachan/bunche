import 'dart:async';

import 'package:bunche/data/datasources/local/hive_database.dart';
// import 'package:bunche/data/models/qrcode.dart';
// import 'package:bunche/data/models/friend.dart';
import 'package:bunche/features/manage_qr_code/respository/friend_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FriendRepositoryImpl implements FriendRepository {
  final String _friendBoxName = 'friends';
  Future<Box<FriendHive>> get _friendBox async =>
      await Hive.openBox(_friendBoxName);

  @override
  Future<List<FriendHive>> getSavedFriends() async {
    try {
      final box = await _friendBox;
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<FriendHive> getFriend(int index) async {
    final box = await _friendBox;
    final FriendHive? friend = box.getAt(index);
    debugPrint('friend: ${friend.toString()}');
    if (friend != null) {
      return friend;
    } else {
      return FriendHive(name: '', qrCodes: []);
    }
  }

  @override
  Future<bool> removeFriend(FriendHive friend, int index) async {
    final box = await _friendBox;
    try {
      await box.deleteAt(index);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<bool> saveFriend(FriendHive friend) async {
    final box = await _friendBox;
    try {
      await box.add(friend);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateFriend(FriendHive friend, int index) async {
    final box = await _friendBox;
    try {
      await box.putAt(index, friend);
      return true;
    } catch (e) {
      return false;
    }
  }
}
