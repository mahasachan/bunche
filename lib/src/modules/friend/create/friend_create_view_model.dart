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
  // QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  QrcodeList qrcodeList = QrcodeList();
  // GroupList groupList = GroupList();

  final NavigationService _navigationService;
  FriendCreateViewModel(this._navigationService);

  List<String> _qrcodeIds = [];
  List<String> get qrcodeIds => _qrcodeIds;

  List<QRCode> _qrcodesPreview = [];
  List<QRCode> get qrcodesPreview => _qrcodesPreview;

  List<String> _groupSelectedIds = [];
  List<String> get groupSelectedIds => _groupSelectedIds;

  Future<void> tryToFetchQrcode(String qrcodeId) async {
    final qrcode = await qrcodeList.tryToFetchQrcode(qrcodeId);
    _qrcodesPreview.add(qrcode);
    _qrcodeIds.add(qrcodeId);
  }

  // Future<void> tryToFetchQrcodes(List<String> qrcodeIds) async {
  //   if (qrcodeIds.isEmpty) return;
  //   for (final qrcodeId in qrcodeIds) {
  //     await tryToFetchQrcode(qrcodeId);
  //   }
  // }

  void tryToFetchQrcodesWithFriendId(String friendId) async {
    final qrcodesTarget = await friendList.tryToFetchQrcodes(friendId);
    if (qrcodesTarget == null) return;
    _qrcodesPreview = [];
    _qrcodeIds = [];
    _qrcodesPreview.addAll(qrcodesTarget);
    for (final qrcode in qrcodesTarget) {
      if (_qrcodeIds.contains(qrcode.id)) continue;
      _qrcodeIds.add(qrcode.id);
    }
    // _qrcodeIds.addAll(qrcodesTarget.map((qrcode) => qrcode.id));
  }

  Future<void> tryToRemoveQrcodeInUpdate(QRCode qrcode) async {
    if (_qrcodeIds.isEmpty) return;
    if (!_qrcodeIds.contains(qrcode.id)) return;
    await qrcodeList.tryRemoveQrcode(qrcode.id);
  }

  void onCreateNewFriend() async {
    final newFriend = Friend(name: nameController.text, qrcodeIds: _qrcodeIds);
    for (final qrcode in _qrcodesPreview) {
      await qrcodeList.tryAddQrcode(qrcode);
    }
    friendList.tryToAddFriend(newFriend);
    _qrcodesPreview = [];
    _qrcodeIds = [];
    _navigationService.goBack();
  }

  void onUpdateFriend(Friend friend) async {
    final String newName = nameController.text;
    // final qrcodeInBox = List<QRCode>.from(qrcodeList.qrcodes);
    for (final qrcode in _qrcodesPreview) {
      if (friend.qrcodeIds!.contains(qrcode.id)) continue;
      await qrcodeList.tryAddQrcode(qrcode);
    }
    await friendList.tryToUpdateFriend(friend, newName, _qrcodeIds);
    _navigationService.goBack();
  }

  void navigateToSelectGroup() async {
    List<String>? groupSelectedIdsTarget =
        await _navigationService.navigateToAwaitData('/selectGroup');
    if (groupSelectedIdsTarget == null) return;
    _groupSelectedIds = groupSelectedIdsTarget;
  }

  void onClickAddQrcode() async {}

  Future<String?> navigateToAddQrcode() async {
    QRCode? qrcodeAdded =
        await _navigationService.navigateToAwaitData('/addQrcode');
    if (qrcodeAdded == null) return null;
    _qrcodesPreview.add(qrcodeAdded);

    if (_qrcodeIds.contains(qrcodeAdded.id)) return null;
    return qrcodeAdded.id;
  }

  Future<String?> navigateToUpDateQrcode(Friend friend) async {
    QRCode? qrcodeAdded =
        await _navigationService.navigateToAwaitData('/addQrcode');
    if (qrcodeAdded == null) return null;
    if (_qrcodeIds.contains(qrcodeAdded.id)) return null;

    friend.tryToAddQrcodeId(qrcodeAdded.id);
    qrcodeList.tryAddQrcode(qrcodeAdded);
    await tryToFetchQrcode(qrcodeAdded.id);
    return qrcodeAdded.id;
  }

  // void navigateToModifyFriend(String friendId) async {
  //   final friend = await friendList.tryToFetchFriend(friendId);

  //   if (friend == null) return;

  //   nameController.text = friend.name;
  //   if (friend.qrcodeIds == null) return;

  //   _qrcodeIds.addAll(friend.qrcodeIds!);
  //   await _navigationService.navigateToWithArguments('/editFriend', [friendId]);
  // }

  void dispose() {
    nameController.dispose();
  }
}
