import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FriendModifyViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  final String friendId;

  final NavigationService _navigationService;
  FriendModifyViewModel(this._navigationService, this.friendId) {
    tryToFetchQrcodes(friendId);
  }

  final List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;

  final List<QRCode> _qrcodesView = [];
  List<QRCode> get qrcodesView => _qrcodesView;

  void onUpdateFriend(Friend friend) async {
    final String newName = nameController.text;
    await friendList.tryToUpdateFriend(friend, newName, _qrcodeIds);
    _navigationService.goBack();
  }

  void navigateToModifyFriend(String friendId) async {
    final friend = await friendList.tryToFetchFriend(friendId);
    if (friend == null) return;

    nameController.text = friend.name;
    if (friend.qrcodeIds == null) return;

    _qrcodeIds.addAll(friend.qrcodeIds!);
    await _navigationService.navigateToWithArguments('/editFriend', [friendId]);
  }

  Future<String?> navigateToAddQrcode(Friend friend) async {
    String? qrcodeId =
        await _navigationService.navigateToAwaitData('/addQrcode');
    if (qrcodeId == null) return null;
    if (_qrcodeIds.contains(qrcodeId)) return null;

    _qrcodeIds.add(qrcodeId);
    friend.tryToAddQrcodeId(qrcodeId);
    final qrcode = await qrcodeList.tryToFetchQrcode(qrcodeId);
    friendList.tryToAddQrcode(qrcode);
    _qrcodesView.add(qrcode);
    return qrcodeId;
  }

  void tryToFetchQrcodes(String friendId) async {
    final qrcodesTarget = await friendList.tryToFetchQrcodes(friendId);
    if (qrcodesTarget == null) return;
    _qrcodesView.addAll(qrcodesTarget);
  }

  Future<void> tryToFetchQrcode(String qrcodeId) async {
    final qrcode = await qrcodeList.tryToFetchQrcode(qrcodeId);
    friendList.qrcodesPreview.add(qrcode);
    _qrcodesView.add(qrcode);
  }

  void dispose() {
    nameController.dispose();
  }
}
