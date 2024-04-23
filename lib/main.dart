import 'package:bunche/config/routes/routes.dart';
import 'package:bunche/core/services/navigator.dart';
import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:bunche/data/datasources/local/hive_qrcode.dart';
import 'package:bunche/features/manage_qr_code/view/friend_list.dart';
import 'package:bunche/features/manage_qr_code/view_model/friend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QRCodeHiveAdapter());
  Hive.registerAdapter(FriendHiveAdapter());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<FriendViewModel>(
        create: (_) => FriendViewModel(NavigationService.instance)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      title: 'Bunche',
      home: const FriendList(),
    );
  }
}
