import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FriendCreateViewModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  FriendList friendList = GetIt.instance.get<FriendList>();
  QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();

  final NavigationService _navigationService;
  FriendCreateViewModel(this._navigationService);

  final List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;

  List<QRCode> _qrcodesPreview = [];
  List<QRCode> get qrcodesPreview => _qrcodesPreview;

  Future<void> tryToFetchQrcode(String qrcodeId) async {
    final qrcode = await qrcodeList.tryToFetchQrcode(qrcodeId);
    _qrcodesPreview.add(qrcode);
    // _qrcodeIds.add(qrcode.id);
  }

  Future<void> tryToFetchQrcodes(List<String> qrcodeIds) async {
    if (qrcodeIds.isEmpty) {
      return;
    }
    for (final qrcodeId in qrcodeIds) {
      await tryToFetchQrcode(qrcodeId);
    }
  }

  void onCreateNewFriend() {
    final newFriend = Friend(name: nameController.text, qrcodeIds: _qrcodeIds);
    friendList.tryToAddFriend(newFriend);
    _qrcodesPreview = [];
    _navigationService.goBack();
  }

  void navigateToSelectGroup() async {
    await _navigationService.navigateTo('/selectGroup');
  }

  Future<String?> navigateToAddQrcode() async {
    String? qrcodeId =
        await _navigationService.navigateToAwaitData('/addQrcode');
    if (qrcodeId == null) return null;
    if (_qrcodeIds.contains(qrcodeId)) return null;
    _qrcodeIds.add(qrcodeId);
    await tryToFetchQrcode(qrcodeId);
    return qrcodeId;
  }

  void dispose() {
    nameController.dispose();
  }
}
