import 'package:bunche/data/datasources/local/hive_database.dart';
// import 'package:bunche/data/models/qrcode.dart';
import 'package:bunche/data/repository/friend_repository_impl.dart';
import 'package:flutter/material.dart';

class FriendService {
  final FriendRepositoryImpl _repository;
  FriendService(this._repository);

  Future<List<FriendHive>> getAllFriends() async {
    try {
      debugPrint('getting friends');
      List<FriendHive> friends = await _repository.getSavedFriends();
      return friends;
    } catch (e) {
      throw Exception('failed to get friends');
    }
  }

  Future<FriendHive> getFriend(int index) async {
    try {
      FriendHive friend = await _repository.getFriend(index);
      return friend;
    } catch (e) {
      throw Exception('failed to get friend');
    }
  }

  Future<bool> deleteFriend(FriendHive friend, int index) async {
    try {
      await _repository.removeFriend(friend, index);
      debugPrint('friend deleted');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> saveFriend(FriendHive friend) async {
    try {
      await _repository.saveFriend(friend);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('failed to save friend');
    }
  }

  Future<bool> updateFriend(FriendHive friend, int index) async {
    try {
      await _repository.updateFriend(friend, index);
      return true;
    } catch (e) {
      debugPrint('failed to update friend');
      debugPrint(e.toString());
      return false;
    }
  }
}
