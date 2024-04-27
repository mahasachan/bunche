import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/services/friend/friend_service.dart';
import 'package:flutter/material.dart';

class FriendList extends ChangeNotifier {
  // static final FriendList _instance = FriendList._internal();
  // factory FriendList() => _instance;
  // FriendList._internal();

  final FriendService _friendService = FriendService();

  List<Friend> _friends = [];
  List<Friend> get friends => _friends;
  List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;

  bool _isFetchingFriends = false;
  bool get isFetchingFriends => _isFetchingFriends;

  void tryToAddFriend(Friend friend) async {
    friend.tryToAddFriend(friend);
    _friends.add(friend);
    debugPrint('In friend list.dart');
    debugPrint('num _friends is ${_friends.length}');
    notifyListeners();
    await _friendService.createFriend(friend);
    debugPrint('num _friends is ${_friends.length}');
    debugPrint('end in friend list.dart');
    _qrcodeIds = [];
  }

  void deleteFriend(Friend friend) {
    friends.remove(friend);
    notifyListeners();
  }

  void tryToAddQrcodeId(Friend friend, String qrcodeId) {
    _qrcodeIds.add(qrcodeId);
    notifyListeners();
    friend.tryToAddQrcodeId(qrcodeId);
    notifyListeners();
  }

  Future<List<Friend>> tryToFetchFriends() async {
    _isFetchingFriends = true;
    var friendsResponse = await _friendService.getFriends();
    _friends = [];
    _friends.addAll(friendsResponse);
    _isFetchingFriends = false;
    notifyListeners();
    return friendsResponse;
  }
}
