import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/qrcode_list_preview.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewFriendProfile extends StatefulWidget {
  const NewFriendProfile({super.key, this.index, this.friendData});
  final int? index;
  final FriendHive? friendData;

  @override
  State<NewFriendProfile> createState() => _NewFriendProfileState();
}

class _NewFriendProfileState extends State<NewFriendProfile> {
  late FriendViewModel viewmodel;
  @override
  Widget build(BuildContext context) {
    viewmodel = Provider.of<FriendViewModel>(context);
    return Scaffold(
        appBar: _buildAppbar(context, viewmodel), body: _buildBody(context));
  }

  _buildAppbar(BuildContext context, FriendViewModel viewmodel) {
    return AppBar(
      title: const Text('New Friend Profile'),
      actions: [
        TextButton(
            onPressed: () async {
              widget.index != null
                  ? await viewmodel.editFriendProfile(widget.index)
                  : await viewmodel.saveProfile();
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<FriendViewModel>(builder: (context, viewmodel, _) {
      return Form(
        key: viewmodel.formkey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.green.shade200),
                  child: TextFormField(
                    validator: (value) {
                      return viewmodel.validateTextFormFiled(value);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name'),
                    controller: viewmodel.nameController,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => viewmodel.addQRCode(context),
                icon: const Icon(Icons.add),
                label: const Text('Add QRcode'),
              ),
              const SizedBox(height: 20),
              Expanded(
                  flex: 6,
                  child: widget.index != null
                      ? QrcodeListPreview(qrcodes: widget.friendData!.qrCodes)
                      : QrcodeListPreview(qrcodes: viewmodel.qrcodes)),
            ],
          ),
        ),
      );
    });
  }
}
