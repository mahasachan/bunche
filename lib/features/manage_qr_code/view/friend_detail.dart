import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/qrcode_list_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendDetail extends StatelessWidget {
  const FriendDetail({
    super.key,
    required this.friend,
    // required this.editQrcode
  });
  final FriendHive friend;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(friend.name),
    );
  }

  _buildBody() {
    debugPrint('friend.qrCodes.length: ${friend.qrCodes.length}');
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return QrcodeListPreview(qrcodes: friend.qrCodes);
      },
    );
  }
}
