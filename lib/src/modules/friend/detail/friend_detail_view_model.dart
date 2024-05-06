import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:get_it/get_it.dart';

class FriendDetailViewModel {
  // final NavigationService _navigationService;
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  final String friendId;

  List<QRCode> _qrcodes = [];
  List<QRCode> get qrcodes => _qrcodes;

  FriendDetailViewModel({required this.friendId}) {
    tryToFetchFriend(friendId);
    tryToFetchQrcodes(friendId);
  }

  void tryToFetchFriend(String friendId) async {
    final friendInList = await friendList.tryToFetchFriend(friendId);
    if (friendInList == null) return;
    // friend = friendInList;
  }

  void tryToFetchQrcodes(String friendId) async {
    final qrcodesInFriend = await friendList.tryToFetchQrcodes(friendId);
    if (qrcodesInFriend == null) return;
    _qrcodes = qrcodesInFriend;
  }
}
