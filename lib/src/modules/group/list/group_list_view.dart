import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/modules/group/list/group_list_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupModifyViewState();
}

class _GroupModifyViewState extends State<GroupListView> {
  late GroupListViewModel groupListViewModel;

  @override
  void initState() {
    super.initState();
    groupListViewModel = GroupListViewModel(NavigationService.instance);
    debugPrint(
        'groupName: ${groupListViewModel.groupList.groups.map((e) => e.groupName)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text('Groups'),
      actions: [
        TextButton.icon(
          onPressed: () {
            groupListViewModel.navigateToCreateGroup();
          },
          icon: const Icon(Icons.add),
          label: const Text('Group'),
        )
      ],
    );
  }

  _buildBody() {
    groupListViewModel.groupList = context.watch<GroupList>();

    return Consumer<GroupList>(
      builder: (context, groupListModel, child) {
        if (groupListModel.isFetchingGroups) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (groupListModel.groups.isEmpty) {
          return const Center(
            child: Text('No Groups'),
          );
        }

        return Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.green.shade100),
              child: Column(
                children: [
                  Text('${groupListModel.groups.length}'),
                  Text('${groupListViewModel.groupList.groups.length}')
                ],
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.green.shade100),
              child: ListView.builder(
                  itemCount: groupListModel.groups.length,
                  itemBuilder: (context, index) {
                    // final groups = groupListViewModel.groupList.groups;
                    // final group = groups[index];
                    // final groupName = group.groupName;
                    // final groups = groupListModel.groups;
                    final group = groupListModel.groups[index];
                    final groupName = group.groupName;
                    return Column(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                groupListViewModel
                                    .navigateToGroupDetails(group);
                              },
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.primaries[
                                      groupName.codeUnitAt(0) %
                                          Colors.primaries.length],
                                  foregroundColor: Colors.white,
                                  radius: 30,
                                  child: Text(groupName[0]),
                                ),
                                title: Text(groupName),
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
                                    onSelected: (String value) async {
                                      if (value == 'Edit') {
                                        await groupListViewModel
                                            .navigateToUpdateGroup(group);
                                      } else if (value == 'Delete') {
                                        groupListViewModel
                                            .tryToDeleteGroup(group);
                                      }
                                    }),
                              ),
                            ),
                          ],
                        )
                        // Text(value.groups[index].groupName),
                      ],
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
