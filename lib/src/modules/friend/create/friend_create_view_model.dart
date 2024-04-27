import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FriendCreateViewModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  // FriendList friendList = FriendList();
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = QrcodeList();
  final NavigationService _navigationService;
  FriendCreateViewModel(this._navigationService);

  final List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;
  // Friend _newFriend = Friend(
  //   name: '',
  //   qrcodeIds: [],
  // );

  void onCreateNewFriend() {
    final newFriend = Friend(name: nameController.text, qrcodeIds: _qrcodeIds);
    friendList.tryToAddFriend(newFriend);
    _navigationService.goBack();
  }

  Future<String?> navigateToAddQrcode() async {
    String? qrcodeId =
        await _navigationService.navigateToAwaitData('/addQrcode');
    if (qrcodeId == null) {
      return null;
    }
    debugPrint('grcodeId: $qrcodeId');
    if (_qrcodeIds.contains(qrcodeId)) {
      return null;
    }
    // _qrcodeIds.add(qrcodeId);
    return qrcodeId;
    // _newFriend = _newFriend.copyWith(qrcodeIds: _qrcodeIds);
    // friendList.tryToAddQrcodeId(_newFriend, qrcodeId);
  }

  void dispose() {
    nameController.dispose();
  }
}
