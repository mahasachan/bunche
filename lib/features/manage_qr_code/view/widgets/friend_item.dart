import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  const FriendItem(
      {super.key,
      required this.onSelectFriend,
      required this.friend,
      required this.onDeleteFriend,
      required this.index,
      required this.onUpdateFriend});

  final FriendHive friend;
  final int index;
  final void Function(int index) onSelectFriend;
  final void Function(FriendHive friend, int index) onDeleteFriend;
  final void Function(FriendHive newriend, int index) onUpdateFriend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          onSelectFriend(index);
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors
                .primaries[friend.name.codeUnitAt(0) % Colors.primaries.length],
            foregroundColor: Colors.white,
            radius: 30,
            child: Text(
              friend.name[0],
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(friend.name),
          // subtitle: Text(friend.qrCodes.length.toString()),
          // subtitle: Text(friend.groupName![0]),
          trailing: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ];
              },
              onSelected: (String value) {
                if (value == 'Edit') {
                  onUpdateFriend(friend, index);
                } else if (value == 'Delete') {
                  onDeleteFriend(friend, index);
                }
              }),
        ),
      ),
    );
  }
}
