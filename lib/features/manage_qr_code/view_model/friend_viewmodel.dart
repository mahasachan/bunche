import 'package:bunche/core/services/friend_service.dart';
import 'package:bunche/core/services/navigator.dart';
import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/data/repository/friend_repository_impl.dart';
import 'package:flutter/material.dart';

class FriendViewModel extends ChangeNotifier {
  final NavigationService _navigationService;
  final FriendService _friendService = FriendService(FriendRepositoryImpl());
  final formkey = GlobalKey<FormState>();
  List<FriendHive> _friends = [];
  List<FriendHive> get friends => _friends;

  List<QRCodeHive> qrCodes = [];
  List<QRCodeHive> get qrcodes => qrCodes;
  // List<QRCodeHive> newQrCodes = [];

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  // controllers

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    // qrCodes.clear();
    super.dispose();
  }

  // constructor

  FriendViewModel(this._navigationService) {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    _isFetching = true;
    notifyListeners();
    _friends = await _friendService.getAllFriends();
    _isFetching = false;
    notifyListeners();
  }

  Future<FriendHive> fetchFriend(int index) async {
    final friend = await _friendService.getFriend(index);
    return friend;
    // notifyListeners();
  }

  void selectFriend(FriendHive friend) async {
    await _navigationService.navigateToWithArguments('/FriendProfile', friend);
  }

  navigateToCreate() async {
    nameController.clear();
    qrCodes = [];
    await _navigationService.navigateTo('/AddFriend');
  }

  Future<void> saveProfile() async {
    String name = nameController.text.trim();
    FriendHive newFriend = FriendHive(
      name: name,
      qrCodes: qrCodes,
    );
    if (!formkey.currentState!.validate()) {
      return;
    }
    final isSuccess = await _friendService.saveFriend(newFriend);
    if (isSuccess) {
      await fetchFriends();
    }
    nameController.clear();
    // qrCodes.clear();
    _navigationService.goBack();
    _navigationService.navigateTo('/friends');
  }

  Future<void> addQRCode(BuildContext context) async {
    final QRCodeHive? qrCode = await Navigator.pushNamed(context, '/AddQrcode');
    if (qrCode == null) return;
    qrCodes.add(qrCode);
    notifyListeners();
  }

  Future<void> fetchQRCode(int index) async {
    final friend = await fetchFriend(index);
    qrCodes = friend.qrCodes;
    notifyListeners();
    // qrCodes = newQrCodes;
    // notifyListeners();
  }

  Future<void> deleteQRCode(int index) async {
    final friend = await fetchFriend(index);
    final name = friend.name;
    final qrcodesInFriend = friend.qrCodes;
    try {
      qrcodesInFriend.removeAt(index);
    } catch (e) {
      _navigationService.showSnackBar('Error deleting QR Code');
    }
    FriendHive updatedFriend = FriendHive(name: name, qrCodes: qrcodesInFriend);

    final isSuccess = await _friendService.updateFriend(updatedFriend, index);
    if (isSuccess) {
      fetchFriends();
      _navigationService.showSnackBar('QR Code deleted successfully');
    }
  }

  navigateToUpdate(FriendHive friend, int index) async {
    nameController.text = friend.name;
    qrCodes = friend.qrCodes;
    await _navigationService
        .navigateToWithArguments('/UpdateFriend', [friend, index]);
  }

  Future<void> editFriendProfile(index) async {
    String name = nameController.text.trim();
    FriendHive editedFriend = FriendHive(
      name: name,
      qrCodes: qrCodes,
    );
    final isSuccess = await _friendService.updateFriend(editedFriend, index);
    if (isSuccess) {
      fetchFriends();
    }
    _navigationService.goBack();
    nameController.clear();
  }

  Future<void> deleteFriend(FriendHive friend, int index) async {
    _navigationService.showLoader();
    final isSuccess = await _friendService.deleteFriend(friend, index);
    _navigationService.goBack();
    if (isSuccess) {
      _friends.removeAt(index);
      _navigationService.showSnackBar('Friend deleted successfully');
      notifyListeners();
    }
  }

  String? validateTextFormFiled(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
