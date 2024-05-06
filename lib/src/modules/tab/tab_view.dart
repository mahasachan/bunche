import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/modules/friend/list/friend_list_view.dart';
import 'package:bunche/src/modules/group/list/group_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = ChangeNotifierProvider.value(
        value: GetIt.instance.get<FriendList>(), child: const FriendListView());
    // String activePageTitle = 'Friends';

    if (_selectedPage == 1) {
      activePage = MultiProvider(providers: [
        ChangeNotifierProvider<FriendList>.value(
            value: GetIt.instance.get<FriendList>()),
        ChangeNotifierProvider<GroupList>.value(value: GroupList()),
      ], child: const GroupListView());
      // activePageTitle = 'Groups';
    }

    return Scaffold(
      // appBar: _buildAppbar(activePageTitle),
      body: _buildBody(activePage),
      bottomNavigationBar:
          _buildBottomNavigationBar(_selectPage, _selectedPage),
    );
  }

  Widget _buildBody(Widget activePage) {
    return activePage;
  }

  BottomNavigationBar _buildBottomNavigationBar(
      void Function(int) selectedPage, int selectedPageIndex) {
    return BottomNavigationBar(
      onTap: selectedPage,
      currentIndex: selectedPageIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Groups',
        ),
      ],
    );
  }
}
