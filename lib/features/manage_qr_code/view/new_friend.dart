// import 'package:bunche/features/manage_qr_code/view/widgets/dialog.dart';
// import 'package:bunche/features/manage_qr_code/view/widgets/form_input.dart';
// import 'package:bunche/features/manage_qr_code/view/widgets/image_input.dart';
import 'package:bunche/data/models/qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/qrcode_list_preview.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewFriendProfile extends StatefulWidget {
  const NewFriendProfile({super.key});

  @override
  State<NewFriendProfile> createState() => _NewFriendProfileState();
}

class _NewFriendProfileState extends State<NewFriendProfile> {
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
    return Consumer<FriendViewModel>(builder: (context, viewmodel, _) {
      return Form(
        key: viewmodel.formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  return viewmodel.validateTextFormFiled(value);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
                controller: viewmodel.nameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => viewmodel.addQRCode(context),
                icon: const Icon(Icons.add),
                label: const Text('Add QRcode'),
              ),
              const SizedBox(height: 20),
              QrcodeListPreview(qrcodes: viewmodel.qrCodes),
              ElevatedButton.icon(
                onPressed: () async {
                  await viewmodel.saveProfile();
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
