import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Create_Account/create_account.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';
import 'package:to_do_list_project/Login_Screen/login_screen.dart';
import 'package:to_do_list_project/NewTask/edit_task.dart';
import 'package:to_do_list_project/appTheme.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';
import 'package:to_do_list_project/provider/auth_user_provider.dart';
import 'package:to_do_list_project/provider/list_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfigProvider = AppConfigProvider();
  await appConfigProvider.loadSettings();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC-tvzmpJ3h53EWJ0p5tdpOrF67BFJcOF4"
        , appId: "com.example.to_do_list_project",
        messagingSenderId: "706053045406",
        projectId: "todo-app-ca07b")
  ): await Firebase.initializeApp();

  runApp( MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ListProvider(),),
      ChangeNotifierProvider(create: (context) => AuthUserProvider(),),
      ChangeNotifierProvider(create: (context) => appConfigProvider,),
  ] ,
  child: MyApp(),)
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          EditTask.routeName: (context) => EditTask(),
          CreateAccount.routeName: (context) => CreateAccount(),
          LoginScreen.routeName : (context)=> LoginScreen()
        },
      initialRoute:LoginScreen.routeName,
      theme:AppTheme.LightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.appTheme,
    );
  }
}


