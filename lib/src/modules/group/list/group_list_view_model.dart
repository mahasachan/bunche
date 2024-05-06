import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
// import 'package:get_it/get_it.dart';

class GroupListViewModel {
  final NavigationService _navigationService;
  GroupListViewModel(this._navigationService) {
    // tryToFetchFriendInGroup(group);
  }

  GroupList groupList = GroupList();

  Future<void> navigateToCreateGroup() async {
    await _navigationService.navigateTo('/addGroup');
    await groupList.tryToFetchGroups();
  }

  Future<void> navigateToGroupDetails(Group group) async {
    final List<Friend> friendInGroup = [];
    if (group.friendIds == null || group.friendIds!.isEmpty) return;
    for (final friendId in group.friendIds!) {
      final Friend? friendTarget = await groupList.tryToFetchFriend(friendId);
      if (friendTarget == null) continue;
      friendInGroup.add(friendTarget);
    }
    await _navigationService
        .navigateToWithArguments('/groupDetail', [friendInGroup, group]);
  }

  void tryToDeleteGroup(Group group) async {
    groupList.tryToremoveGroup(group);
  }

  Future<void> navigateToUpdateGroup(Group group) async {
    await _navigationService.navigateToWithArguments('/editGroup', group);
  }
}
