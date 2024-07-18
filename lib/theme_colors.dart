part of 'project.dart';

abstract class _ThemeColors {
  final String primaryColor;
  final String primaryVariantColor;
  final String textColor;
  String white = 'FFFFFF';
  String blue = '4a85fd';
  String red = 'c42b1c';
  String green = '1dbf73';

  _ThemeColors({
    required this.primaryColor,
    required this.primaryVariantColor,
    required this.textColor,
    this.white = 'FFFFFF',
    this.blue = '4a85fd',
    this.red = 'c42b1c',
    this.green = '1dbf73',
  });
}

/// Light theme colors
class LightThemeColors extends _ThemeColors {
  /// Light theme colors constructor
  LightThemeColors({
    required super.primaryColor,
    required super.primaryVariantColor,
    required super.textColor,
  });
}

/// Dark theme colors
class DarkThemeColors extends _ThemeColors {
  /// Dark theme colors constructor
  DarkThemeColors({
    required super.primaryColor,
    required super.primaryVariantColor,
    required super.textColor,
  });
}
