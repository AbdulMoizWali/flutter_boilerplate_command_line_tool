import 'package:flutter_boilerplate_tool/flutter_boilerplate_tool.dart';
import 'package:flutter_boilerplate_tool/project.dart';

void main() {
  print('Running flutter_boilerplate_tool example...');

  Project project = Project(
    projectImportName: 'test_app',
    lightThemeColors: LightThemeColors(
      primaryColor: 'f9d6e3',
      primaryVariantColor: 'f9d6e3',
      textColor: '000000',
    ),
    darkThemeColors: DarkThemeColors(
      primaryColor: 'efacda',
      primaryVariantColor: 'f9d6e3',
      textColor: '000000',
    ),
    screens: ['home', 'profile', 'settings'],
    currentTheme: 'light',
  );

  // Call the main function of your CLI tool
  createBoilerplateCode(project);
}
