import 'package:bunche/src/common/components/friend_item.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/modules/friend/list/friend_list_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendListView extends StatefulWidget {
  const FriendListView({super.key});

  @override
  State<FriendListView> createState() => _FriendListState();
}

class _FriendListState extends State<FriendListView> {
  FriendListViewModel friendListViewModel =
      FriendListViewModel(NavigationService.instance);
  // @override
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
        if (friendListData.isFetchingFriends) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        debugPrint('friendListData.friends= ${friendListData.friends}');
        if (friendListData.friends.isEmpty) {
          return const Center(
            child: Text('You don\'t have any friends'),
          );
        }
        return friendListView(friendListData);
      },
    );
  }

  ListView friendListView(FriendList friendListData) {
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        return FriendItem(
          index: index,
          friend: friendListData.friends[index],
          // onUpdateFriend: (friend, index) {
          //   viewModel.navigateToUpdate(friend, index);
          // },
          // onDeleteFriend: (friend, index) {
          //   viewModel.deleteFriend(friend, index);
          // },
          // onSelectFriend: (index) {
          //   viewModel.selectFriend(index);
          // },
        );
      },
      itemCount: friendListData.friends.length,
    );
  }

  @override
  void dispose() {
    // friendListProvider.dispose();
    super.dispose();
  }
}
