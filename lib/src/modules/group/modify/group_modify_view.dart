import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/modules/group/modify/group_modify_view_model.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupModifyView extends StatefulWidget {
  const GroupModifyView({super.key, this.isEditing = false, this.group});

  final bool isEditing;
  final Group? group;

  @override
  State<GroupModifyView> createState() => _GroupModifyViewState();
}

class _GroupModifyViewState extends State<GroupModifyView> {
  late GroupModifyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = GroupModifyViewModel(NavigationService.instance);
    if (widget.isEditing || widget.group != null) {
      viewModel.setUpInitialUpdateGroup(widget.group!, widget.isEditing);
      debugPrint('friend is : ${viewModel.friends.map((e) => e.name)}');
      debugPrint(
          'friendSeletedMap is : ${viewModel.friendSeletedMap.entries.map((e) => e.value)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context, viewModel),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context, GroupModifyViewModel viewModel) {
    return AppBar(
      title: const Text('Create Group'),
      actions: [
        TextButton(
            onPressed: () {
              if (viewModel.formKey.currentState!.validate()) {
                widget.isEditing
                    ? viewModel.tryToUpdateGroup(widget.group!)
                    : viewModel.tryToAddGroup();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }

  _buildBody() {
    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (!viewModel.validateFormNotEmpty(value)) {
                  return 'Please enter a group name';
                }
                if (!viewModel.validateFormUnique(value!) &&
                    !widget.isEditing) {
                  return 'Group name already exists';
                }
                return null;
              },
              controller: viewModel.groupNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Group Name',
              ),
            ),
            Consumer<GroupList>(
              builder: (context, value, _) => Flexible(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: ListView.builder(
                        itemCount: viewModel.friends.length,
                        // itemCount: value.friendsInGroup.length,
                        itemBuilder: (context, index) {
                          return Text(viewModel.friends[index].name);
                          // return Text(value.friendsInGroup[index].name);
                        }),
                  )),
            ),
            Consumer<FriendList>(builder: (context, friendListModel, child) {
              return Flexible(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: ListView.builder(
                      itemCount: friendListModel.friends.length,
                      itemBuilder: (context, index) {
                        final friend = friendListModel.friends[index];
                        final friendId = friend.id;
                        final friendName = friend.name;
                        return Container(
                          padding: const EdgeInsets.all(12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.primaries[
                                  friendName.codeUnitAt(0) %
                                      Colors.primaries.length],
                              foregroundColor: Colors.white,
                              radius: 30,
                              child: Text(
                                friendName[0],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            title: Text(friendName),
                            trailing: Consumer<GroupList>(
                              builder: (context, value, child) => Checkbox(
                                value: viewModel.friendSeletedMap[friendId],
                                onChanged: (isCheck) {
                                  if (isCheck!) {
                                    viewModel.tryToAddFriendToGroup(friendId);
                                    setState(() {
                                      viewModel.friends.add(friend);
                                    });
                                    debugPrint(
                                        'friend is : ${viewModel.friends.map((e) => e.name)}');
                                  } else {
                                    viewModel
                                        .tryToRemoveFriendFromGroup(friendId);
                                    setState(() {
                                      viewModel.friends.remove(friend);
                                    });
                                    debugPrint(
                                        'friend is : ${viewModel.friends.map((e) => e.name)}');
                                  }
                                  setState(() {
                                    viewModel.friendSeletedMap[friendId] =
                                        isCheck;
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
