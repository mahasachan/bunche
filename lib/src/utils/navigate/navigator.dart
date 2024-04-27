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

  navigateToAwaitData<T>(String routeName) async {
    debugPrint('Navigating to $routeName');
    return (await navigatorKey.currentState!.pushNamed(routeName)) as T;
  }

  nvigateBackWithData(Object data) {
    navigatorKey.currentState!.pop(data);
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

  showSnackBar(String message) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }
}
