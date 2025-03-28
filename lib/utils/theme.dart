import 'package:flutter/material.dart';

ThemeData collectoTheme = ThemeData(
        primaryColor: Color.fromRGBO(9, 235, 176, 1),
        highlightColor: Color(0xFF1C2C38),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Color(0xFF1C2C38)),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Color.fromRGBO(9, 235, 176, 1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF09EBB0), 
            foregroundColor: Color(0xFF1C2C38)
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStateProperty.all(
            IconThemeData(color: Color(0xFF1C2C38))
          ),
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(color: Color(0xFF1C2C38))
          ),
          
        )
      );