import 'dart:typed_data';

import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/modules/camera/camera_view.dart';
import 'package:bunche/src/modules/friend/create/friend_create_view.dart';
import 'package:bunche/src/modules/friend/detail/friend_detail_view.dart';
import 'package:bunche/src/modules/friend/list/friend_list_view.dart';
import 'package:bunche/src/modules/friend/modify/friend_modify_view.dart';
import 'package:bunche/src/modules/qrcode/create/qrcode_create_view.dart';
import 'package:bunche/src/modules/qrcode/detail/qrcode_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/camera':
        return MaterialPageRoute(builder: (_) => const CameraView());
      case '/addFriend':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<FriendList>.value(
                value: GetIt.instance.get<FriendList>(),
                child: const FriendCreateView()));
      case '/addQrcode':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<QrcodeList>.value(
                  value: QrcodeList(),
                  child: const QrcodeCreateView(),
                ));

      case '/friends':
        return MaterialPageRoute(builder: (_) => const FriendListView());
      case '/QrcodeDetail':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
                value: GetIt.instance.get<QrcodeList>(),
                child: QrcodeDetailView(
                  accountName: args[0] as String,
                  qrCodeImage: args[1] as Uint8List,
                )));
      // case '/AddFriend':
      //   return MaterialPageRoute(builder: (_) => const NewFriendProfile());
      // case '/AddQrcode':
      //   return MaterialPageRoute<QRCode>(builder: (_) => const NewQRcode());
      case '/UpdateProfile':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
                value: GetIt.instance.get<FriendList>(),
                child: FriendModifyView(friend: args[0], index: args[1])));
      case '/FriendProfile':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
                value: GetIt.instance.get<FriendList>(),
                child:
                    FriendDetailView(friendId: args[0], friendName: args[1])));
      // case '/SelectGroup':
      //   return MaterialPageRoute(builder: (_) => const SelectGroup());

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
