import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';

class FriendDetail extends StatelessWidget {
  const FriendDetail({super.key, required this.friend});
  final FriendHive friend;
  // final FriendViewModel friendViewModel;
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

  // Build the body of the screen.

  _buildBody() {
    debugPrint('friend.qrCodes.length: ${friend.qrCodes.length}');
    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle),
                  title: Text(friend.qrCodes[index].accountName),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.blue.shade200),
                  height: 200,
                  width: double.infinity,
                  child: Image.memory(
                    friend.qrCodes[index].qrCodeImage,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
        itemCount: friend.qrCodes.length);
  }
}
