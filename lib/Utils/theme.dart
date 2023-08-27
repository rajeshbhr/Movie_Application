import 'package:flutter/material.dart';
import 'colors.dart';

final theme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: kScaffoldBackgroundColor,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: kScaffoldBackgroundColor)
);
