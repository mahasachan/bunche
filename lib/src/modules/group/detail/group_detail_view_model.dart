import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:get_it/get_it.dart';

class GroupDetailViewModel {
  GroupList groupList = GroupList();
  FriendList friendList = GetIt.instance.get<FriendList>();
  final Group group;

  GroupDetailViewModel(this.group) {
    fetchFriendsInGroup(group);
  }

  Future<void> fetchFriendsInGroup(Group group) async {
    await groupList.tryToFetchFriendInGroup(group);
  }
}
