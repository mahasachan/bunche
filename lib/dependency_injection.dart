import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/data/models/group_list.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:bunche/src/data/services/friend/friend_service.dart';
import 'package:bunche/src/data/services/qrcode/qrcode_service.dart';
import 'package:get_it/get_it.dart';

final singleton = GetIt.instance;
Future<void> initializeDependencies() async {
  singleton.registerSingleton<FriendList>(FriendList());
  singleton.registerSingleton(FriendService());

  singleton.registerSingleton<QrcodeList>(QrcodeList());
  singleton.registerSingleton(QrcodeService());
  singleton.registerSingleton<GroupList>(GroupList());
}
