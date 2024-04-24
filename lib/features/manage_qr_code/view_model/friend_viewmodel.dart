import 'package:bunche/core/services/friend_service.dart';
import 'package:bunche/core/services/group_service.dart';
import 'package:bunche/core/services/navigator.dart';
import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/data/datasources/local/hive_group.dart';
import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/data/repository/friend_repository_impl.dart';
import 'package:bunche/data/repository/group_repository_impl.dart';
import 'package:flutter/material.dart';

class FriendViewModel extends ChangeNotifier {
  final NavigationService _navigationService;
  final FriendService _friendService = FriendService(FriendRepositoryImpl());
  final GroupService _groupService = GroupService(GroupRepositoryImpl());

  final formkey = GlobalKey<FormState>();
  final groupNameFormKey = GlobalKey<FormState>();
  List<FriendHive> _friends = [];
  List<FriendHive> get friends => _friends;

  List<QRCodeHive> qrCodes = [];
  List<QRCodeHive> get qrcodes => qrCodes;

  final List<String> _groupNames = [];
  List<String> get groupNames => _groupNames;

  late List<bool> _isGroupNameSelected = List.filled(_groupNames.length, false);
  List<bool> get isGroupNameSelected => _isGroupNameSelected;

  final Map<String, bool> _isGroupNameSelectedMap = {};
  Map<String, bool> get isGroupNameSelectedMap => _isGroupNameSelectedMap;

  List<String> _selectedGroupName = [];
  List<String> get selectedGroupName => _selectedGroupName;

  // List<QRCodeHive> newQrCodes = [];

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  // controllers

  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // constructor

  FriendViewModel(this._navigationService) {
    fetchFriends();
    fetchGroups();
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

  void selectFriend(int index) async {
    final friend = await fetchFriend(index);
    // qrCodes = friend.qrCodes;
    debugPrint('selected friend: $friend');
    await _navigationService.navigateToWithArguments('/FriendProfile', friend);
  }

  navigateToCreate() async {
    nameController.clear();
    groupNameController.clear();
    _selectedGroupName = [];
    _isGroupNameSelected = List.filled(_groupNames.length, false);
    qrCodes = [];
    await _navigationService.navigateTo('/AddFriend');
  }

  Future<void> saveProfile({int? index}) async {
    String name = nameController.text.trim();
    FriendHive newFriend = FriendHive(
      name: name,
      qrCodes: qrCodes,
      groupName: _selectedGroupName,
    );
    if (!formkey.currentState!.validate()) {
      return;
    }
    bool isSuccess;
    if (index != null) {
      isSuccess = await _friendService.updateFriend(newFriend, index);
    } else {
      isSuccess = await _friendService.saveFriend(newFriend);
    }
    if (isSuccess) {
      fetchFriends();
    }
    nameController.clear();
    _selectedGroupName = [];
    _isGroupNameSelected = List.filled(_groupNames.length, false);
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

  // Future<void> editFriendProfile(int? index) async {
  //   String name = nameController.text.trim();
  //   FriendHive editedFriend = FriendHive(
  //     name: name,
  //     qrCodes: qrCodes,
  //   );
  //   final isSuccess = await _friendService.updateFriend(editedFriend, index);
  //   if (isSuccess) {
  //     fetchFriends();
  //   }
  //   _navigationService.goBack();
  //   nameController.clear();
  // }

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

  Future<void> fetchGroups() async {
    final List<GroupHive> grouphive = await _groupService.getAllGroups();
    for (final group in grouphive) {
      _groupNames.add(group.groupName);
    }
    notifyListeners();
    debugPrint('groupName: $_groupNames');
  }

  navigationToSelectGroup() async {
    await _navigationService.navigateTo('/SelectGroup');
  }

  Future<void> setGroup(String groupName, bool isSelected, int index) async {
    if (isSelected) {
      _selectedGroupName.add(groupName);
      notifyListeners();
      _navigationService.showSnackBar('add to $groupName');
    } else {
      _selectedGroupName.remove(groupName);
      notifyListeners();
      _navigationService.showSnackBar('remove from $groupName');
    }
    _isGroupNameSelected[index] = isSelected;
    notifyListeners();
    debugPrint('selectedGroupName: $_selectedGroupName');
  }

  Future<void> addGroupName() async {
    final newGroupName = groupNameController.text.trim();

    if (!groupNameFormKey.currentState!.validate()) {
      groupNameController.clear();
      return;
    }
    final GroupHive newGroupHiveName = GroupHive(groupName: newGroupName);
    await _groupService.addGroup(newGroupHiveName);

    _groupNames.add(newGroupName);
    // _selectedGroupName = newGroupName;
    notifyListeners();
    _navigationService.goBack();
    groupNameController.clear();
    _navigationService.showSnackBar('Group name added successfully');
  }

  Future<void> addFriendToGroup(FriendHive friend, int index) async {
    final updatedFriend = FriendHive(
      name: friend.name,
      qrCodes: friend.qrCodes,
      // groupName: _selectedGroupName,
    );
    _friendService.updateFriend(updatedFriend, index);
    _navigationService.goBack();
    _navigationService.showSnackBar('Friend added to group successfully');
  }

  // validator
  String? validateGroupName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length > 30) {
      return 'Input must be less than 30 characters';
    } else if (value.contains(' ')) {
      return 'Input must not contain spaces';
    } else if (_groupNames.contains(value)) {
      return 'Group name already exists';
    }
    return null;
  }

  String? validateTextFormFiled(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length > 30) {
      return 'Input must be less than 30 characters';
    } else if (value.contains(' ')) {
      return 'Input must not contain spaces';
    }
    return null;
  }
}
