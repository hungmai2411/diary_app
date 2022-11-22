import 'package:diary_app/my_app.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  MyApp.routeName: (context) => MyApp(),
};

// MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
//   switch (settings.name) {
//   }
// }