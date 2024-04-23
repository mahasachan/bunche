import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/friend_detail.dart';
import 'package:bunche/features/manage_qr_code/view/friend_list.dart';
import 'package:bunche/features/manage_qr_code/view/new_friend.dart';
import 'package:bunche/features/manage_qr_code/view/new_qr_code.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/friends':
        return MaterialPageRoute(builder: (_) => const FriendList());
      case '/AddFriend':
        return MaterialPageRoute(builder: (_) => const NewFriendProfile());
      case '/AddQrcode':
        return MaterialPageRoute<QRCodeHive?>(
            builder: (_) => const NewQRcode());
      case '/UpdateFriend':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => NewFriendProfile(
                  friendData: args[0] as FriendHive,
                  index: args[1] as int,
                ));
      case '/FriendProfile':
        return MaterialPageRoute(
            builder: (_) =>
                FriendDetail(friend: settings.arguments as FriendHive));

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
