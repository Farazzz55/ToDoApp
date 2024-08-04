

 import 'package:flutter/material.dart';
import 'package:to_do_list_project/appColors.dart';

class AppTheme{
  static final LightTheme=ThemeData(
    primaryColor: AppColors.priamryColor,
    scaffoldBackgroundColor: AppColors.bgLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.priamryColor,
      elevation: 0,
    ) ,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontSize: 22,
      ),
    ) ,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.priamryColor,
      unselectedItemColor: AppColors.gray,
      unselectedIconTheme: IconThemeData(
        size: 35
      ),
      selectedIconTheme: IconThemeData(
        size: 40
      ),
      elevation: 0 ,
      backgroundColor: Colors.transparent

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.priamryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(
          width: 4,
          color: AppColors.white
        )
      )
    )

  );
 }
