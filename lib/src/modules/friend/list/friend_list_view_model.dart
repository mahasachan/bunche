// import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:get_it/get_it.dart';

class FriendListViewModel {
  // FriendList friendList = FriendList();
  FriendList friendList = GetIt.instance.get<FriendList>();

  final NavigationService _navigationService;

  // Private fields
  // final List<Friend> _friends = [];
  // List<Friend> get friends => _friends;

  FriendListViewModel(this._navigationService) {
    fetchFriends();
  }

  void fetchFriends() async {
    await friendList.tryToFetchFriends();
  }

  void navigateToCreateFriend() async {
    await _navigationService.navigateTo('/addFriend');
  }
}
