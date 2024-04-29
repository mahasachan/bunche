// import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:get_it/get_it.dart';

class FriendListViewModel {
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();

  final NavigationService _navigationService;

  FriendListViewModel(this._navigationService) {
    fetchFriends();
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

  void tryToDeleteFriend(Friend friend) async {
    await friendList.tryTodeleteFriend(friend);
    if (friend.qrcodeIds == null) return;
    for (final qrcodeId in friend.qrcodeIds!) {
      await qrcodeList.tryRemoveQrcode(qrcodeId);
    }
  }

  void tryToEditFriend(Friend friend) async {
    await _navigationService
        .navigateToWithArguments('/editFriend', [friend.id, friend.name]);
  }
}
