import 'package:bunche/src/common/components/qrcode_list_preview.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/modules/friend/detail/friend_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendDetailView extends StatefulWidget {
  const FriendDetailView({
    super.key,
    required this.friendId,
    required this.friendName,
  });
  final String friendId;
  final String friendName;

  @override
  State<FriendDetailView> createState() => _FriendDetailViewState();
}

class _FriendDetailViewState extends State<FriendDetailView> {
  late FriendDetailViewModel friendDetailViewModel;
  // late FriendList friendList;

  @override
  void initState() {
    super.initState();
    friendDetailViewModel = FriendDetailViewModel(friendId: widget.friendId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(widget.friendName), body: _buildBody(context));
  }

  _buildAppBar(String friendName) {
    return AppBar(
      title: Text(friendName),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<FriendList>(
        builder: (BuildContext context, FriendList value, _) {
      return QrcodeListPreview(qrcodes: value.qrcodesPreview);
    });
  }
}
