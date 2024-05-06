import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GroupModifyViewModel {
  final NavigationService _navigationService;
  GroupList groupList = GroupList();
  FriendList friendList = GetIt.instance.get<FriendList>();

  final List<String> _groupNames = [];
  List<String> get groupNames => _groupNames;

  List<Friend> friends = [];
  Map<String, bool> friendSeletedMap = {};

  late final List<bool> _isSeletedFriends =
      List.filled(friendList.friends.length, false);
  List<bool> get isSeletedFriends => _isSeletedFriends;

  TextEditingController groupNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GroupModifyViewModel(this._navigationService) {
    initFriendSelectedMap();
    fetchGroupsName();
  }

  Future<void> fetchGroupsName() async {
    await groupList.tryToFetchGroups();
    for (final group in groupList.groups) {
      _groupNames.add(group.groupName);
    }
  }

  Future<void> fetchFriendWithIds(List<String> friendIds) async {
    friends = [];
    for (final friendId in friendIds) {
      final friendTarget = await friendList.tryToFetchFriend(friendId);
      if (friendTarget == null) continue;
      friends.add(friendTarget);
    }
  }

  void setUpInitialSelectedFriends(Group? group, bool? isEdit) {
    if (isEdit == false || group == null) return;
    final friendIds = group.friendIds;
    if (friendIds == null) return;
    for (final friend in friends) {
      if (friendIds.contains(friend.id)) {
        friendSeletedMap[friend.id] = true;
      } else {
        friendSeletedMap[friend.id] = false;
      }
    }
  }

  void setUpInitialUpdateGroup(Group group, bool? isEdit) async {
    groupNameController.text = group.groupName;
    final friendIds = group.friendIds;
    if (friendIds == null) return;
    await fetchFriendWithIds(friendIds);
    setUpInitialSelectedFriends(group, true);
  }

  void initFriendSelectedMap() {
    for (final friend in friendList.friends) {
      friendSeletedMap[friend.id] = false;
    }
  }

  void setFriend(Friend friend, bool isSeleted, int index) {
    if (isSeleted) {
      groupList.tryToAddFriendIdToGroup(friend.id);
      _navigationService.showSnackBar('add to $friend');
    } else {
      groupList.tryToRemoveFriendIdFromGroup(friend.id);
      _navigationService.showSnackBar('remove from $friend');
    }
    friendSeletedMap[friend.id] = isSeleted;
  }

  Future<void> tryToAddGroup() async {
    if (groupList.friendIds.isEmpty) {
      _navigationService
          .showSnackBar('Please select at least one friend to create group');
      return;
    }

    Group newGroup = Group(
      groupName: groupNameController.text,
      friendIds: groupList.friendIds,
    );

    groupList.tryToaddGroup(newGroup);
    groupNames.add(newGroup.groupName);
    groupNameController.clear();
    _navigationService.goBack();
  }

  void tryToUpdateGroup(Group group) async {
    final List<String> newFriendIds = [];
    for (int i = 0; i < friends.length; i++) {
      if (friendSeletedMap[friends[i].id] == true) {
        newFriendIds.add(friends[i].id);
      }
    }

    groupList.tryToUpdateGroup(group, newFriendIds, groupNameController.text);
    groupNameController.clear();
    _navigationService.goBack();
  }

  Future<void> tryToRemoveGroup(Group group) async {
    groupList.tryToremoveGroup(group);
    groupNames.remove(group.groupName);
  }

  Future<void> tryToAddFriendToGroup(String friendId) async {
    if (groupList.friendIds.contains(friendId)) return;
    groupList.tryToAddFriendIdToGroup(friendId);
  }

  Future<void> tryToRemoveFriendFromGroup(String friendId) async {
    if (!groupList.friendIds.contains(friendId)) return;
    groupList.tryToRemoveFriendIdFromGroup(friendId);
  }

  bool validateFormNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool validateFormUnique(String value) {
    if (_groupNames.contains(value)) {
      return false;
    }
    return true;
  }

  void dispose() {
    groupNameController.dispose();
  }
}
