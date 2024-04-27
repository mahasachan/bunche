// import 'package:hive/hive.dart';
import 'dart:async';

import 'package:bunche/src/common/constants/hive.dart';
import 'package:bunche/src/data/models/friend/friend.dart';
import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/group/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  Future<Box<Friend>> get friendBox async {
    return await Hive.openBox(friendStoreBoxName);
  }

  Future<Box<QRCode>> get qrcodeBox async {
    return await Hive.openBox(qrCodeStoreBoxName);
  }

  Future<Box<Group>> get groupBox async {
    return await Hive.openBox(groupStoreBoxName);
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(QRCodeAdapter());
    Hive.registerAdapter(FriendAdapter());
    Hive.registerAdapter(GroupAdapter());
  }
}
