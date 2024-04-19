import 'package:bunche/features/manage_qr_code/view/list_friend.dart';
import 'package:bunche/features/manage_qr_code/view/list_group.dart';
import 'package:bunche/features/manage_qr_code/view/new_friend.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/friends':
        return MaterialPageRoute(builder: (_) => const FriendList());
      case '/group':
        return MaterialPageRoute(builder: (_) => const GroupList());
      case '/AddFriend':
        return MaterialPageRoute(builder: (_) => const NewFriendProfile());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
