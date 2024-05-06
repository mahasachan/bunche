// import 'dart:typed_data';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/modules/friend/create/friend_create_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendCreateView extends StatefulWidget {
  const FriendCreateView(
      {super.key, this.friend, this.index, this.isEdit = false});
  final Friend? friend;
  final int? index;
  final bool isEdit;

  @override
  State<FriendCreateView> createState() => _FriendCreateViewState();
}

class _FriendCreateViewState extends State<FriendCreateView> {
  FriendCreateViewModel friendCreateViewModel =
      FriendCreateViewModel(NavigationService.instance);

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      friendCreateViewModel.tryToFetchQrcodesWithFriendId(widget.friend!.id);
      friendCreateViewModel.nameController.text = widget.friend!.name;
      friendCreateViewModel.qrcodeIds.addAll(widget.friend!.qrcodeIds ?? []);
    }
  }

  @override
  void dispose() {
    super.dispose();
    friendCreateViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text('New Friend Profile'),
      actions: [
        TextButton(
            onPressed: () {
              if (friendCreateViewModel.formKey.currentState!.validate()) {
                widget.isEdit
                    ? friendCreateViewModel.onUpdateFriend(widget.friend!)
                    : friendCreateViewModel.onCreateNewFriend();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<FriendList>(
      builder: (context, friendList, child) => Form(
        key: friendCreateViewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
                controller: friendCreateViewModel.nameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 10),
              _buildButtonRow(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'QRcode List',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildQrcodeList(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () async {
            final qrcodeId = await friendCreateViewModel.navigateToAddQrcode();
            if (qrcodeId == null) return;
            setState(() {
              friendCreateViewModel.qrcodeIds.add(qrcodeId);
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('QRcode'),
        ),
      ],
    );
  }

  Flexible _buildQrcodeList() {
    return Flexible(
        flex: 6,
        child: SizedBox(
          width: double.infinity,
          child: ListView.builder(
              itemCount: friendCreateViewModel.qrcodesPreview.length,
              itemBuilder: (context, index) {
                if (friendCreateViewModel.qrcodesPreview.isEmpty) {
                  return const Center(
                    child: Text('No QR Codes'),
                  );
                }
                // final accountName =
                // friendCreateViewModel.qrcodesPreview[index].accountName;
                // final qrcodeImage =
                // friendCreateViewModel.qrcodesPreview[index].qrCodeImage;
                // final qrcodeId = friendCreateViewModel.qrcodesPreview[index].id;
                return _buildQrcodeCard(
                    friendCreateViewModel.qrcodesPreview[index]);
              }),
        ));
  }

  Column _buildQrcodeCard(
    QRCode qrcode,
  ) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                title: Text(qrcode.accountName),
                subtitle: Text(
                  'Secondary Text',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.memory(
                  qrcode.qrCodeImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              _buildButtonBar(qrcode)
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  ButtonBar _buildButtonBar(QRCode qrcode) {
    return ButtonBar(
      alignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {
            if (widget.isEdit) {
              friendCreateViewModel.tryToRemoveQrcodeInUpdate(qrcode);
            }
            setState(() {
              friendCreateViewModel.qrcodeIds.remove(qrcode.id);
              friendCreateViewModel.qrcodesPreview.remove(qrcode);
            });
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

class ShowListGroupSeleted extends StatelessWidget {
  const ShowListGroupSeleted({
    super.key,
    required this.groupNames,
  });

  final List<String> groupNames;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GridView.builder(
          itemCount: groupNames.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return Container(
              // margin: const EdgeInsets.all(),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.45),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  groupNames[index],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }),
    );
  }
}
