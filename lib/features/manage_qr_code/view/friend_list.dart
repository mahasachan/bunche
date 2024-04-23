// import 'package:bunche/data/datasources/local/hive_database.dart';
// import 'package:bunche/data/mockup.dart';
// import 'package:bunche/data/models/friend.dart';
import 'package:bunche/features/manage_qr_code/view/widgets/friend_item.dart';
// import 'package:bunche/features/manage_qr_code/view_model/friend_list_viewmodel.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  late FriendViewModel friendListProvider;
  // @override

  @override
  Widget build(BuildContext context) {
    friendListProvider = Provider.of<FriendViewModel>(context);
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: () {},
      //   currentIndex: ,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon:Icon(Icons.people),
      //       label: 'Friends'

      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.group),
      //       label: 'Groups'
      //     ),
      //   ],

      // ),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text('Your Friends'),
      actions: [
        IconButton(
          onPressed: () async {
            await friendListProvider.navigateToCreate();
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  _buildBody() {
    return Consumer<FriendViewModel>(
      builder: (context, viewmodel, _) {
        if (viewmodel.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (viewmodel.friends.isEmpty) {
          return const Center(
            child: Text('You don\'t have any friends'),
          );
        }
        return friendListView(viewmodel);
      },
    );
  }

  ListView friendListView(FriendViewModel viewModel) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return FriendItem(
          index: index,
          friend: viewModel.friends[index],
          onUpdateFriend: (friend, index) {
            viewModel.navigateToUpdate(friend, index);
          },
          onDeleteFriend: (friend, index) {
            viewModel.deleteFriend(friend, index);
          },
          onSelectFriend: viewModel.selectFriend,
        );
      },
      itemCount: viewModel.friends.length,
    );
  }

  @override
  void dispose() {
    friendListProvider.dispose();
    super.dispose();
  }
}
