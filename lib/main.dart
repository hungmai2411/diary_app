import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/bottom_navigation_provider.dart';
import 'package:diary_app/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (_) => BottomNavigationProvider(),
        ),
      ],
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        //onGenerateRoute: generateRoutes,
        home: const MyApp(),
      ),
    ),
  );
}
