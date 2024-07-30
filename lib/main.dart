import 'package:flutter/material.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';
import 'package:to_do_list_project/appTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (context)=> HomeScreen()
      },
      initialRoute:HomeScreen.routeName,
      theme: AppTheme.LightTheme

    );
  }
}


