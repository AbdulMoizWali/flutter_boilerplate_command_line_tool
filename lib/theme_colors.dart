// ignore_for_file: annotate_overrides, overridden_fields

abstract class ThemeColors {
  final String primaryColor;
  final String primaryVariantColor;
  final String textColor;
  String white = 'FFFFFF';
  String blue = '4a85fd';
  String red = 'c42b1c';
  String green = '1dbf73';

  ThemeColors({
    required this.primaryColor,
    required this.primaryVariantColor,
    required this.textColor,
    this.white = 'FFFFFF',
    this.blue = '4a85fd',
    this.red = 'c42b1c',
    this.green = '1dbf73',
  });
}

class LightThemeColors extends ThemeColors {
  LightThemeColors({
    required super.primaryColor,
    required super.primaryVariantColor,
    required super.textColor,
  });
}

class DarkThemeColors extends ThemeColors {
  DarkThemeColors({
    required super.primaryColor,
    required super.primaryVariantColor,
    required super.textColor,
  });
}
