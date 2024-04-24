import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectGroup extends StatefulWidget {
  const SelectGroup({super.key});

  @override
  State<SelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<SelectGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Consumer<FriendViewModel>(
        builder: (BuildContext context, FriendViewModel viewModel, _) {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: ListView.builder(
                itemCount: viewModel.groupNames.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == viewModel.groupNames.length) {
                    return Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Group'),
                        onPressed: () {
                          _showDialog(context, viewModel);
                        },
                      ),
                    );
                  }
                  return CheckboxListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30, right: 20),
                      value: viewModel.isGroupNameSelected[index],
                      title: Text(viewModel.groupNames[index]),
                      onChanged: (isCheck) {
                        viewModel.setGroup(
                            viewModel.groupNames[index], isCheck!, index);
                      });
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text('Select Group'),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16),
            ))
      ],
    );
  }

  _showDialog(BuildContext context, FriendViewModel viewmodel) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    viewmodel.addGroupName();
                  },
                  child: const Text('Add'))
            ],
            title: const Text('Create New Group'),
            content: Form(
              key: viewmodel.groupNameFormKey,
              child: TextFormField(
                validator: (value) {
                  return viewmodel.validateGroupName(value);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Group Name'),
                controller: viewmodel.groupNameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          );
        });
  }
}
