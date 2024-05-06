import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
// import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/data/services/friend/friend_service.dart';
import 'package:bunche/src/data/services/qrcode/qrcode_service.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

class FriendList extends ChangeNotifier {
  final FriendService _friendService = FriendService();
  final QrcodeService _qrcodeService = QrcodeService();
  // QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  List<Friend> friends = [];
  // List<Friend> get friends => _friends;
  List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;

  List<QRCode> _qrcodesPreview = [];
  List<QRCode> get qrcodesPreview => _qrcodesPreview;

  bool _isFetchingFriends = false;
  bool get isFetchingFriends => _isFetchingFriends;

  bool _isFetchingQrcodes = false;
  bool get isFetchingQrcodes => _isFetchingQrcodes;

  void tryToAddFriend(Friend friend) async {
    friend.tryToAddFriend(friend);
    friends.add(friend);
    notifyListeners();
    await _friendService.createFriend(friend);
    _qrcodeIds = [];
  }

  Future<void> tryTodeleteFriend(Friend friend) async {
    for (final qrcodeId in friend.qrcodeIds!) {
      qrcodeIds.remove(qrcodeId);
    }
    friends.remove(friend);
    await _friendService.deleteFriend(friend.id);
    notifyListeners();
  }

  Future<void> getfilterFriendInGroup(List<String> group) async {
    friends = [];
    final friendsResponse = await _friendService.getFriends();
    friends.addAll(friendsResponse);
  }

  void tryToAddQrcodeId(Friend friend, String qrcodeId) {
    _qrcodeIds.add(qrcodeId);
    notifyListeners();
    friend.tryToAddQrcodeId(qrcodeId);
    notifyListeners();
  }

  void tryToRemoveQrcodeId(Friend friend, String qrcodeId) {
    _qrcodeIds.remove(qrcodeId);
    notifyListeners();
    friend.tryToRemoveQrcodeId(qrcodeId);
    notifyListeners();
  }

  Future<List<Friend>> tryToFetchFriends() async {
    _isFetchingFriends = true;
    var friendsResponse = await _friendService.getFriends();
    friends = [];
    friends.addAll(friendsResponse);
    _isFetchingFriends = false;
    notifyListeners();
    return friendsResponse;
  }

  Future<void> tryToAddQrcode(QRCode qrcode) async {
    _qrcodesPreview.add(qrcode);
    notifyListeners();
  }

  Future<Friend?> tryToFetchFriend(String friendId) async {
    var friendResponse = await _friendService.getFriend(friendId);
    if (friendResponse == null) return null;
    return friendResponse;
  }

  Future<List<QRCode>?> tryToFetchQrcodes(String friendId) async {
    _qrcodesPreview = [];
    final friendResponse = await _friendService.getFriend(friendId);
    if (friendResponse == null) return null;
    if (friendResponse.qrcodeIds == null) return null;
    _isFetchingQrcodes = true;
    final qrcodesResponse = await _qrcodeService.getQrcodes();
    List<QRCode> filteredQrcodes = qrcodesResponse
        .where((qrcode) => friendResponse.qrcodeIds!.contains(qrcode.id))
        .toList();
    _isFetchingQrcodes = false;
    _qrcodesPreview = filteredQrcodes;
    notifyListeners();
    return filteredQrcodes;
  }

  Future<void> tryToUpdateFriend(
      Friend friend, String? newName, List<String>? newQrcodeId) async {
    friend.tryToUpdateFriend(newName!, newQrcodeId!);
    await _friendService.upDateFriend(friend);
    notifyListeners();
  }
}
