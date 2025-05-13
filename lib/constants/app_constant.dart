import 'package:flutter/material.dart';

abstract class AppColors {
  static final Color primaryColor = Color(0xff3C75EF);
  static final Color scaffoldBackColor = Color(0xffF4F4F4);
  static final Color cardTextColor = Color(0xffA4BFF8);
  static final Color iconBackColor = Color(0xffEAF0FD);
  static final Color listTileSmallTextColor = Color(0xff6F7076);
}

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.scaffoldBackColor,
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        iconColor: AppColors.primaryColor,
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}

abstract class AppTextTheme {
  static final TextStyle cardBoldTextStyle = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle cardSmallTextStyle = TextStyle(
    color: AppColors.cardTextColor,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w800,
  );
}
