import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigateTo(String routeName) async {
    await navigatorKey.currentState!.pushNamed(routeName);
  }

  navigateToWithArguments(String routeName, Object arguments) async {
    await navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Object navigateToAwaitData(String routeName) async {
    final data = (await navigatorKey.currentState!.pushNamed(routeName))!;
    return data;
  }

  replaceWith(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }

  showLoader() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: navigatorKey.currentState!.context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
