import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier{
  ThemeMode appTheme=ThemeMode.light;

  void changeTheme(ThemeMode newTheme){
    if(appTheme==newTheme){
      return;
    }
    appTheme=newTheme;
    notifyListeners();
  }
  bool isDark(){
    return appTheme==ThemeMode.dark;
  }
  Future<void> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    appTheme = prefs.getString('Mode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Mode', appTheme == ThemeMode.dark ? 'dark' : 'light');
  }
}