import 'package:bunche/src/common/components/friend_item.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/modules/friend/list/friend_list_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendListView extends StatefulWidget {
  const FriendListView(
      {super.key, this.isFromGroup = false, this.friendsInGroup, this.group});
  final bool isFromGroup;
  final List<Friend>? friendsInGroup;
  final Group? group;

  @override
  State<FriendListView> createState() => _FriendListState();
}

class _FriendListState extends State<FriendListView> {
  late List<Friend> friendsData;
  late bool isFetching;
  FriendListViewModel friendListViewModel =
      FriendListViewModel(NavigationService.instance);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    // final FriendList friendList = context.watch<FriendList>();
    return AppBar(
      title: const Text('Your Friends'),
      actions: [
        IconButton(
          onPressed: () {
            friendListViewModel.navigateToCreateFriend();
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  _buildBody() {
    return Consumer<FriendList>(
      builder: (context, friendListData, _) {
        if (widget.isFromGroup &&
            widget.friendsInGroup != null &&
            widget.group != null) {
          // friendsData = widget.friendsInGroup!;
          friendListData.friends = widget.friendsInGroup!;
          friendsData = friendListData.friends;
          isFetching = friendListViewModel.groupList.isFetchingGroups;
        } else {
          friendsData = friendListData.friends;
          isFetching = friendListData.isFetchingFriends;
        }
        if (isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (friendsData.isEmpty) {
          return const Center(
            child: Text('You don\'t have any friends'),
          );
        }
        return Container(child: friendListView(friendsData));
      },
    );
  }

  ListView friendListView(List<Friend> friendListData) {
    return ListView.builder(
      // reverse: true,
      itemBuilder: (context, index) {
        final Friend friend = friendListData[index];
        return FriendItem(
          index: index,
          friend: friend,
          onUpdateFriend: (friend, index) {
            friendListViewModel.navigateToEditFriend(friend, index);
          },
          onDeleteFriend: (friend) {
            friendListViewModel.tryToDeleteFriendIdFromGroup(friend.id);
            friendListViewModel.tryToDeleteFriend(
                friend, widget.friendsInGroup, widget.group);
          },
          onSelectFriend: (id) {
            friendListViewModel.navigateToFriendDetails(
                friendListData[index].id, friendListData[index].name);
          },
        );
      },
      itemCount: friendListData.length,
    );
  }

  @override
  void dispose() {
    // friendListProvider.dispose();
    super.dispose();
  }
}
