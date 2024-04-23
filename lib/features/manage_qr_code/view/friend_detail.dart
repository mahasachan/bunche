import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/card_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
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
      title: Text('Friend Detail ${friend.name}'),
    );
  }

  _buildBody() {
    debugPrint('friend.qrCodes.length: ${friend.qrCodes.length}');
    return Consumer<FriendViewModel>(
      builder: (context, viewmodel, child) {
        return _listviewBuilder(viewmodel);
      },
    );
  }

  ListView _listviewBuilder(FriendViewModel viewModel) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return CardQrcode(
            qrCode: viewModel.qrcodes[index].qrCodeImage,
            accountName: viewModel.qrcodes[index].accountName,
            onEditQrcode: () {},
            index: index,
          );
        },
        itemCount: viewModel.qrcodes.length);
  }
}
