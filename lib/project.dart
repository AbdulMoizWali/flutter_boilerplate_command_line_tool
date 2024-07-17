import 'package:flutter_boilerplate_tool/theme_colors.dart';

class Project {
  final String projectImportName;
  final LightThemeColors lightThemeColors;
  final DarkThemeColors darkThemeColors;
  final List<String> screens;
  final String currentTheme;

  Project({
    required this.projectImportName,
    required this.lightThemeColors,
    required this.darkThemeColors,
    required this.screens,
    required this.currentTheme,
  });
}
