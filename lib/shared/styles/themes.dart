import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: HexColor('333333'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:  HexColor('333333'),
        statusBarIconBrightness: Brightness.light,
      ),
      color:  HexColor('333333'),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.white
      ),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('333333'),
        elevation: 50.0
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        )
    )
);

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.black
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      elevation: 0.0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 50.0
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        )
    )
);