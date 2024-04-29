import 'package:bunche/src/data/models/friend/friend.dart';

abstract class FriendServiceInterface {
  Future<List<Friend>> getFriends();
  Future<Friend?> getFriend(String friendId);
  Future<bool> deleteFriend(String friendId);
  Future<Friend> upDateFriend(Friend friend);
  Future<Friend> createFriend(Friend friend);
  Future<void> addQrcodeToFriend(String friendId, String qrcodeId);
}
