import 'package:bunche/src/data/models/friend_list.dart';
// import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/modules/friend/create/friend_create_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendCreateView extends StatefulWidget {
  const FriendCreateView({super.key});

  @override
  State<FriendCreateView> createState() => _FriendCreateViewState();
}

class _FriendCreateViewState extends State<FriendCreateView> {
  FriendCreateViewModel friendCreateViewModel =
      FriendCreateViewModel(NavigationService.instance);

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
              friendCreateViewModel.onCreateNewFriend();
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }

  _buildBody(BuildContext context) {
    // QrcodeList qrcodeList = context.watch<QrcodeList>();
    // friendCreateViewModel.qrcodeList = qrcodeList;
    FriendList friendList = context.watch<FriendList>();
    friendCreateViewModel.friendList = friendList;
    return Consumer<FriendList>(
      builder: (context, friendList, child) =>
          _buildFormCreateNewFriend(friendList),
    );
  }

  Form _buildFormCreateNewFriend(FriendList friendList) {
    return Form(
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
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
                    final qrcodeId =
                        await friendCreateViewModel.navigateToAddQrcode();
                    if (qrcodeId == null) return;
                    setState(() {
                      friendCreateViewModel.qrcodeIds.add(qrcodeId);
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('QRcode'),
                ),
              ],
            ),
            // const SizedBox(height: 20),
            // ShowListGroupSeleted(groupNames: .selectedGroupName),
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
            Text(friendCreateViewModel.qrcodeIds.length.toString()),
            // Text(friendCreateViewModel.friendList.grcodeIds.length.toString()),
            Flexible(
              flex: 6,
              child: ListView.builder(
                  itemCount: friendCreateViewModel.qrcodeIds.length,
                  itemBuilder: (context, index) {
                    return Text(friendCreateViewModel.qrcodeIds[index]);
                  }),
            ),
            //

            // Expanded(
            //     flex: 6,
            //     child: widget.index != null
            //         ? QrcodeListPreview(
            //             qrcodes: widget.friendData!.qrCodes,
            //             isEdit: true,
            //           )
            //         : QrcodeListPreview(
            //             qrcodes: viewmodel.qrcodes,
            //             isEdit: true,
            //           )),
          ],
        ),
      ),
    );
  }
}

// class NewFriendProfile extends StatefulWidget {
//   const NewFriendProfile({super.key, this.index, this.friendData});
//   final int? index;
//   final Friend? friendData;

//   @override
//   State<NewFriendProfile> createState() => _NewFriendProfileState();
// }

// class _NewFriendProfileState extends State<NewFriendProfile> {
//   late FriendViewModel viewmodel;

//   // List<String> items = ['No group', 'item1', 'item2', 'item3'];
//   // String selectedItem = '';
//   @override
//   Widget build(BuildContext context) {
//     viewmodel = Provider.of<FriendViewModel>(context);
//     return Scaffold(
//         appBar: _buildAppbar(context, viewmodel), body: _buildBody(context));
//   }

//   _buildAppbar(BuildContext context, FriendViewModel viewmodel) {
//     return AppBar(
//       title: widget.index != null
//           ? const Text('Edit Friend Profile')
//           : const Text('New Friend Profile'),
//       actions: [
//         TextButton(
//             onPressed: () async {
//               await viewmodel.saveProfile(
//                 index: widget.index,
//               );
//             },
//             child: const Text(
//               'Save',
//               style: TextStyle(fontSize: 16),
//             ))
//       ],
//     );
//   }

//   _buildBody(BuildContext context) {
//     return Consumer<FriendViewModel>(builder: (context, viewmodel, _) {
//       return Form(
//         key: viewmodel.formkey,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 validator: (value) {
//                   return viewmodel.validateTextFormFiled(value);
//                 },
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(), labelText: 'Name'),
//                 controller: viewmodel.nameController,
//                 style: TextStyle(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       viewmodel.navigationToSelectGroup();
//                     },
//                     child: const Text('Select Group'),
//                   ),
//                   const SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: () => viewmodel.addQRCode(context),
//                     icon: const Icon(Icons.add),
//                     label: const Text('QRcode'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ShowListGroupSeleted(groupNames: viewmodel.selectedGroupName),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'QRcode List',
//                     style: TextStyle(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onBackground
//                           .withOpacity(0.7),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                   flex: 6,
//                   child: widget.index != null
//                       ? QrcodeListPreview(
//                           qrcodes: widget.friendData!.qrCodes,
//                           isEdit: true,
//                         )
//                       : QrcodeListPreview(
//                           qrcodes: viewmodel.qrcodes,
//                           isEdit: true,
//                         )),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

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
