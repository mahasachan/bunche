import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/services/friend/friend_service.dart';
import 'package:bunche/src/data/services/group/group_service.dart';
import 'package:flutter/material.dart';

class GroupList extends ChangeNotifier {
  List<Group> _groups = [];
  List<Group> get groups => _groups;

  final List<String> _friendIds = [];
  List<String> get friendIds => _friendIds;

  List<Friend> _friendsInGroup = [];
  List<Friend> get friendsInGroup => _friendsInGroup;

  bool _isFetchingGroups = false;
  bool get isFetchingGroups => _isFetchingGroups;

  Map<String, bool> friendSelectedMap = {};

  final GroupService _groupService = GroupService();
  final FriendService _friendService = FriendService();

  GroupList() {
    tryToFetchGroups();
  }

  void tryToaddGroup(Group group) async {
    await _groupService.createGroup(group);
    if (_groups.contains(group)) return;
    await tryToFetchGroups();
  }

  void tryToremoveGroup(Group group) async {
    _groups.remove(group);
    await _groupService.deleteGroup(group.id);
    await tryToFetchGroups();
    // notifyListeners();
  }

  void tryToUpdateGroup(
      Group group, List<String> friendIds, String groupName) async {
    group.tryToUpdateGroup(friendIds, groupName);
    await _groupService.upDateGroup(group);
    await tryToFetchGroups();
  }

  void tryToAddFriendIdToGroup(String friendId) async {
    if (!_friendIds.contains(friendId)) _friendIds.add(friendId);
    final Friend? friend = await tryToFetchFriend(friendId);
    if (friend == null) return;
    _friendsInGroup.add(friend);
    notifyListeners();
    //
  }

  Future<void> tryToRemoveFriendIdFromGroup(String friendId) async {
    if (_friendIds.contains(friendId)) _friendIds.remove(friendId);
    final Friend? friend = await tryToFetchFriend(friendId);
    if (friend == null) return;
    _friendsInGroup.remove(friend);
    notifyListeners();
  }

  void tryToAddFriendToGroup(Group group, String friendId) {
    group.tryToAddFriend(group, friendId);
    notifyListeners();
  }

  void tryToRemoveFriendFromGroup(Group group, String friendId) {
    group.tryToRemoveFriend(group, friendId);
    notifyListeners();
  }

  void tryToAddFriendId(Group group, String friendId) {
    if (!_friendIds.contains(friendId)) {
      _friendIds.add(friendId);
      notifyListeners();
      group.tryToAddFriend(group, friendId);
    }

    notifyListeners();
  }

  Future<Friend?> tryToFetchFriend(String friendId) async {
    final friendTarget = await _friendService.getFriend(friendId);
    if (friendTarget == null) return null;
    return friendTarget;
  }

  Future<void> tryToFetchFriendInGroup(Group group) async {
    _isFetchingGroups = true;
    notifyListeners();

    _friendsInGroup = [];
    List<String>? friendIdsTarget = group.tryToFetchFriendIds(group);
    if (friendIdsTarget == null) return;
    if (friendIdsTarget.isEmpty) {
      tryToremoveGroup(group);
    }
    for (final friendIdTarget in friendIdsTarget) {
      final friendTarget = await _friendService.getFriend(friendIdTarget);
      if (friendTarget == null) return;
      _friendsInGroup.add(friendTarget);
      notifyListeners();
    }
    _isFetchingGroups = false;
    notifyListeners();
  }

  Future<void> tryToFetchGroups() async {
    _groups = [];
    final groups = await _groupService.getGroups();
    for (final group in groups) {
      _groups.add(group);
      notifyListeners();
    }
  }

  Future<void> tryToFetchGroup(String groupId) async {
    await _groupService.getGroup(groupId);
    // notifyListeners();
  }
}
