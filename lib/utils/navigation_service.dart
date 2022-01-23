import 'package:flutter/widgets.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(Route route) {
    navigatorKey.currentState?.push(route);
  }
}