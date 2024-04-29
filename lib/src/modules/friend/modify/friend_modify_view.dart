import 'package:bunche/src/common/components/qrcode_list_preview.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/modules/friend/modify/friend_modify_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendModifyView extends StatefulWidget {
  const FriendModifyView(
      {super.key, required this.friend, required this.index});
  final Friend friend;
  final int index;

  @override
  State<FriendModifyView> createState() => _FriendModifyViewState();
}

class _FriendModifyViewState extends State<FriendModifyView> {
  late FriendModifyViewModel friendModifyViewModel;

  @override
  void initState() {
    super.initState();
    friendModifyViewModel =
        FriendModifyViewModel(NavigationService.instance, widget.friend.id);
    friendModifyViewModel.nameController.text = widget.friend.name;
    friendModifyViewModel.qrcodeIds.addAll(widget.friend.qrcodeIds ?? []);
  }

  @override
  void dispose() {
    super.dispose();
    friendModifyViewModel.dispose();
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
              friendModifyViewModel.onUpdateFriend(widget.friend);
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
        key: friendModifyViewModel.formKey,
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
                controller: friendModifyViewModel.nameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // viewmodel.navigationToSelectGroup();
                    },
                    child: const Text('Select Group'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final qrcodeId = await friendModifyViewModel
                          .navigateToAddQrcode(widget.friend);
                      if (qrcodeId == null) return;
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('QRcode'),
                  ),
                ],
              ),
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
              Flexible(
                  flex: 6,
                  child: QrcodeListPreview(
                    qrcodes: friendList.qrcodes,
                    isEdit: true,
                  )),
            ],
          ),
        ),
      ),
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
