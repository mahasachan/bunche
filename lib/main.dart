import 'package:bunche/dependency_injection.dart';
import 'package:bunche/routes.dart';
import 'package:bunche/src/data/models/friend_list.dart';
import 'package:bunche/src/modules/friend/list/friend_list_view.dart';
import 'package:bunche/src/utils/cache/hive_manager.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await HiveManager.initialize();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      title: 'Bunche',
      home: MultiProvider(providers: [
        ChangeNotifierProvider<FriendList>(
            create: (context) => GetIt.instance.get<FriendList>()),
      ], child: const FriendListView()),
    );
  }
}
