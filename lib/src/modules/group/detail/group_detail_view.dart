import 'package:bunche/src/common/components/friend_item.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/modules/group/detail/group_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupDetailView extends StatefulWidget {
  const GroupDetailView({super.key, required this.group});
  final Group group;

  @override
  State<GroupDetailView> createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  late GroupDetailViewModel groupDetailViewModel;

  @override
  void initState() {
    super.initState();
    groupDetailViewModel = GroupDetailViewModel(widget.group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: Text(widget.group.groupName),
    );
  }

  _buildBody() {
    return Consumer<GroupList>(
      builder: (context, groupListModel, _) => ListView.builder(
          itemCount: groupListModel.friendsInGroup.length,
          itemBuilder: (context, index) {
            if (groupListModel.isFetchingGroups) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (groupListModel.friendsInGroup.isEmpty) {
              return const Center(
                child: Text('No friends in this group'),
              );
            }
            return FriendItem(
              friend: groupListModel.friendsInGroup[index],
            );
          }),
    );
  }
}
