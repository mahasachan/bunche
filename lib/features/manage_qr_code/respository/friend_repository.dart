import 'package:bunche/data/datasources/local/hive_database.dart';
// import 'package:flutter/material.dart';
// import 'package:bunche/data/models/qrcode.dart';

abstract class FriendRepository {
  Future<List<FriendHive>> getSavedFriends();
  Future<FriendHive?> getFriend(int index);
  Future<bool> saveFriend(FriendHive friend);
  Future<bool> removeFriend(FriendHive friend, int index);
  Future<bool> updateFriend(FriendHive friend, int index);
  // Future<List<QRCode>> getFriendQrcodes(String friendId);
  // Future<void> saveFriendQrcode(QRCode qrcode);
  // Future<void> removeFriendQrcode(QRCode qrcode);
  // Future<void> updateFriendQrcode(QRCode qrcode);
}
