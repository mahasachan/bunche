// import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:get_it/get_it.dart';

class FriendListViewModel {
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = QrcodeList();
  GroupList groupList = GroupList();

  final NavigationService _navigationService;

  FriendListViewModel(this._navigationService) {
    fetchFriends();
    qrcodeList.tryToFetchQrcodes();
  }

  void fetchFriends() async {
    await friendList.tryToFetchFriends();
  }

  void navigateToCreateFriend() async {
    await _navigationService.navigateTo('/addFriend');
  }

  void navigateToFriendDetails(String friendId, String friendName) async {
    await _navigationService
        .navigateToWithArguments('/FriendProfile', [friendId, friendName]);
  }

  void navigateToEditFriend(Friend friend, int index) async {
    await _navigationService
        .navigateToWithArguments('/UpdateProfile', [friend, index]);
  }

  void tryToDeleteFriend(
      Friend friend, List<Friend>? friendIdsIngroup, Group? group) async {
    if (friend.qrcodeIds == null) return;
    final qrcodeIdsInFriend = List<String>.from(friend.qrcodeIds!);
    for (final qrcodeId in qrcodeIdsInFriend) {
      await qrcodeList.tryRemoveQrcode(qrcodeId);
    }
    await friendList.tryTodeleteFriend(friend);
    if (friendIdsIngroup!.isEmpty && group != null) {
      groupList.tryToremoveGroup(group);
      _navigationService.goBack();
    }
  }

  void tryToDeleteFriendIdFromGroup(String friendId) async {
    await groupList.tryToRemoveFriendIdFromGroup(friendId);
  }

  void tryToEditFriend(Friend friend) async {
    await _navigationService
        .navigateToWithArguments('/editFriend', [friend.id, friend.name]);
  }

  // void filterFriends
}
