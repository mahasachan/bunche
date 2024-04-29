import 'package:bunche/src/common/constants/hive.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/services/friend/friend_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FriendService implements FriendServiceInterface {
  Future<Box<Friend>> get _friendBox async =>
      await Hive.openBox(friendStoreBoxName);

  @override
  Future<Friend> createFriend(Friend friend) async {
    final box = await _friendBox;
    try {
      await box.put(friend.id, friend);
      await box.close();
      return friend;
    } catch (e) {
      debugPrint('Error creating friend: $e');
      return Future.error('Error creating friend');
    }
  }

  @override
  Future<bool> deleteFriend(String friendId) async {
    final box = await _friendBox;
    try {
      await box.delete(friendId);
      await box.close();
      return true;
    } catch (e) {
      debugPrint('Error deleting friend: $e');
      return false;
    }
  }

  @override
  Future<Friend?> getFriend(String friendId) async {
    final box = await _friendBox;
    if (box.isOpen) {
      debugPrint('Box is open');
    }
    Friend? friend;
    try {
      friend = box.get(friendId);
      debugPrint('Friend: $friend');
      return friend;
    } catch (e) {
      debugPrint('Error getting friend: $e');
      return Future.error('Error getting friend');
    }
  }

  @override
  Future<List<Friend>> getFriends() async {
    final box = await _friendBox;
    final friends = box.values.toList();
    await box.close();
    return friends;
  }

  @override
  Future<Friend> upDateFriend(Friend friend) async {
    final box = await _friendBox;
    try {
      // await box.putAt(index, friend);
      await box.put(friend.id, friend);
      await box.close();
      return friend;
    } catch (e) {
      debugPrint('Error updating friend: $e');
      return Future.error('Error updating friend');
    }
  }

  @override
  Future<void> addQrcodeToFriend(String friendId, String qrcodeId) async {
    final box = await _friendBox;
    final friend = box.get(friendId);

    if (friend != null) {
      friend.qrcodeIds ??= [];
      friend.qrcodeIds?.add(qrcodeId);
      await box.put(friendId, friend);
    }
  }
}
