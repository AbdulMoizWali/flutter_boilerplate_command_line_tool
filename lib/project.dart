part 'theme_colors.dart';

/// A class containing all the info for the client project.
class Project {
  /// The name of the project to import.
  final String projectImportName;

  /// The light theme colors.
  final LightThemeColors lightThemeColors;

  /// The dark theme colors.
  final DarkThemeColors darkThemeColors;

  /// The list of screens.
  final List<String> screens;

  /// The current theme.
  final String currentTheme;

  /// Project constructor.
  Project({
    required this.projectImportName,
    required this.lightThemeColors,
    required this.darkThemeColors,
    required this.screens,
    required this.currentTheme,
  });
}
