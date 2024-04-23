// import 'package:bunche/features/manage_qr_code/view/widgets/dialog.dart';
// import 'package:bunche/features/manage_qr_code/view/widgets/form_input.dart';
// import 'package:bunche/features/manage_qr_code/view/widgets/image_input.dart';
// import 'package:bunche/data/datasources/local/hive_database.dart';
// import 'package:bunche/data/models/qrcode.dart';
import 'package:bunche/core/services/navigator.dart';
import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/qrcode_list_preview.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
// import 'package:bunche/features/manage_qr_code/view_model/new_friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateFriendProfile extends StatefulWidget {
  final FriendHive friendData;
  final int index;
  const UpdateFriendProfile(
      {super.key, required this.friendData, required this.index});

  @override
  State<UpdateFriendProfile> createState() => _NewFriendProfileState();
}

class _NewFriendProfileState extends State<UpdateFriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(context), body: _buildBody(context));
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text('New Friend Profile'),
    );
  }

  _buildBody(BuildContext context) {
    debugPrint('friendData: ${widget.friendData.qrCodes.toList()}');
    return Consumer<FriendViewModel>(builder: (context, viewmodel, _) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: viewmodel.formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // initialValue: viewmodel.nameController.text,
                validator: (value) {
                  viewmodel.validateTextFormFiled(value);
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
                controller: viewmodel.nameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async => await viewmodel.addQRCode(context),
                icon: const Icon(Icons.add),
                label: const Text('Add QRcode'),
              ),
              const SizedBox(height: 20),
              QrcodeListPreview(qrcodes: widget.friendData.qrCodes),
              ElevatedButton.icon(
                onPressed: () async {
                  await viewmodel.editFriendProfile(widget.index);
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
