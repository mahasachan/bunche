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

  // List<String> items = ['No group', 'item1', 'item2', 'item3'];
  // String selectedItem = '';
  @override
  Widget build(BuildContext context) {
    viewmodel = Provider.of<FriendViewModel>(context);
    return Scaffold(
        appBar: _buildAppbar(context, viewmodel), body: _buildBody(context));
  }

  _buildAppbar(BuildContext context, FriendViewModel viewmodel) {
    return AppBar(
      title: widget.index != null
          ? const Text('Edit Friend Profile')
          : const Text('New Friend Profile'),
      actions: [
        TextButton(
            onPressed: () async {
              await viewmodel.saveProfile(
                index: widget.index,
              );
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.navigationToSelectGroup();
                    },
                    child: const Text('Select Group'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => viewmodel.addQRCode(context),
                    icon: const Icon(Icons.add),
                    label: const Text('QRcode'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ShowListGroupSeleted(groupNames: viewmodel.selectedGroupName),
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
              Expanded(
                  flex: 6,
                  child: widget.index != null
                      ? QrcodeListPreview(
                          qrcodes: widget.friendData!.qrCodes,
                          isEdit: true,
                        )
                      : QrcodeListPreview(
                          qrcodes: viewmodel.qrcodes,
                          isEdit: true,
                        )),
            ],
          ),
        ),
      );
    });
  }
}

class ShowListGroupSeleted extends StatelessWidget {
  const ShowListGroupSeleted({
    super.key,
    required this.groupNames,
  });

  // final FriendViewModel viewmodel;
  // final String groupName;
  // final int numItems;
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
