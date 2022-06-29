import 'package:flutter/material.dart';
class CustomThemes{
  static TextStyle errorTextStyle=const TextStyle(
    fontSize: 22,
    color: Colors.red
  );
  static List<ThemeData>themes=[
    ThemeData(primarySwatch: Colors.teal
    ,iconTheme: const IconThemeData(
          color: Colors.black
        )),
    ThemeData(primarySwatch: Colors.deepOrange
  ,iconTheme: const IconThemeData(
  color: Colors.black
  )),
    ThemeData(primarySwatch: Colors.blue
  ,iconTheme: const IconThemeData(
  color: Colors.yellow
  )),
  ];
}