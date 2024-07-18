import 'package:flutter_boilerplate_tool/flutter_boilerplate_tool.dart'
    as flutter_boilerplate_tool;

// void main(List<String> arguments) {
//   print('Hello world: ${flutter_boilerplate_tool.calculate()}!');
// }

import 'dart:io';
import 'package:args/args.dart';
import 'package:flutter_boilerplate_tool/project.dart';

void main(List<String> arguments) {
  // I created this code in only 2-3 hours. So, I didn't add any error handling yet. Also the code is not refactored.
  // I have tested it is working fine. But if you find any issue, please let me know.
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage');

  final argResults = parser.parse(arguments);

  if (argResults['help'] as bool) {
    print('Usage: dart run flutter_boilerplate_tool:create');
    print(parser.usage);
    return;
  }

  print(
      'NOTE: This will override main and some other files. You should run this first.');
  stdout.write('Do you want to continue? (y/N): ');
  final continueResponse = stdin.readLineSync()?.toLowerCase();
  if (continueResponse != 'y') {
    print('Operation cancelled.');
    return;
  }

  stdout.write("Project Import Package name (like 'flutter_demo_app') : ");
  final importPackageName = stdin.readLineSync();

  print('\n============ Light Theme ===========');
  print(
      '\nNote: Use hex color code without # \nlike (eeeeee, ffffff, 000000)\n');
  stdout.write('LightPrimaryColor: ');
  final lightPrimaryColor = stdin.readLineSync();
  stdout.write('LightPrimaryVariantColor: ');
  final lightPrimaryVariantColor = stdin.readLineSync();
  stdout.write('LightTextColor: ');
  final lightTextColor = stdin.readLineSync();

  print('\n============ Dark Theme ===========');
  stdout.write('DarkPrimaryColor: ');
  final darkPrimaryColor = stdin.readLineSync();
  stdout.write('DarkPrimaryVariantColor: ');
  final darkPrimaryVariantColor = stdin.readLineSync();
  stdout.write('DarkTextColor: ');
  final darkTextColor = stdin.readLineSync();

  stdout.write('\nCurrent Theme? (light, dark): ');
  final currentTheme = stdin.readLineSync();

  stdout.write('\n============ Screens ============ ');
  stdout.write(
      '\nNote: No capital letter and no special character except \'_\' and no need to add "_screen" suffix.');
  stdout.write('\nExample: home, profile, settings\n');

  List<String> screens = [];
  while (true) {
    stdout.write('Screen${screens.length + 1}: ');
    final screen = stdin.readLineSync();
    screens.add(screen!.trim().toLowerCase());

    stdout.write('Add more screens? (y/N): ');
    final addMoreScreens = stdin.readLineSync()?.toLowerCase();
    if (addMoreScreens != 'y') {
      break;
    }
  }

  Project project = Project(
    projectImportName: importPackageName!,
    lightThemeColors: LightThemeColors(
      primaryColor: lightPrimaryColor!,
      primaryVariantColor: lightPrimaryVariantColor!,
      textColor: lightTextColor!,
    ),
    darkThemeColors: DarkThemeColors(
      primaryColor: darkPrimaryColor!,
      primaryVariantColor: darkPrimaryVariantColor!,
      textColor: darkTextColor!,
    ),
    screens: screens,
    currentTheme: currentTheme!,
  );

  flutter_boilerplate_tool.createBoilerplateCode(
    project,
  );

  print('\x1B[32m');
  print('Boilerplate code created successfully.');
}
