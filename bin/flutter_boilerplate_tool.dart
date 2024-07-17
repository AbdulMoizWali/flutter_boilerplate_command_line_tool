import 'package:flutter_boilerplate_tool/flutter_boilerplate_tool.dart'
    as flutter_boilerplate_tool;

// void main(List<String> arguments) {
//   print('Hello world: ${flutter_boilerplate_tool.calculate()}!');
// }

import 'dart:io';
import 'package:args/args.dart';
import 'package:flutter_boilerplate_tool/project.dart';
import 'package:flutter_boilerplate_tool/theme_colors.dart';

void main(List<String> arguments) {
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
      '\nNote: Use hex color code without # \n like (eeeeee, ffffff, 000000)\n');
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

  createBoilerplateCode(
    project,
  );

  print('\x1B[32m');
  print('Boilerplate code created successfully.');
}

void createBoilerplateCode(
  Project project,
) {
  final directoryStructure = {
    'lib/theme': ['theme_colors.dart', 'theme_builder.dart'],
    'lib/helpers': ['gap.dart'],
    'lib/routes': ['route_path.dart', 'route_generator.dart'],
    'lib/screens': project.screens
        .map((screen) => '${screen.toLowerCase()}_screen.dart')
        .toList(),
    'lib': ['main.dart']
  };

  directoryStructure.forEach((directory, files) {
    Directory(directory).createSync(recursive: true);
    for (var file in files) {
      File('$directory/$file').writeAsStringSync(
        getFileContent(
          file,
          project,
        ),
      );
    }
  });
}

String getFileContent(
  String fileName,
  Project project,
) {
  if (fileName == 'theme_colors.dart') {
    return flutter_boilerplate_tool.generateThemeColorsFile(
      project.lightThemeColors,
      project.darkThemeColors,
    );
  } else if (fileName == 'theme_builder.dart') {
    return flutter_boilerplate_tool.generateThemeBuilderFile(
      project.projectImportName,
    );
  } else if (fileName == 'gap.dart') {
    return flutter_boilerplate_tool.generateGapFile();
  } else if (fileName == 'route_path.dart') {
    return flutter_boilerplate_tool.generateRoutePathFile(project);
  } else if (fileName == 'route_generator.dart') {
    return flutter_boilerplate_tool.generateRouteGeneratorFile(
      project,
    );
  } else if (fileName == 'main.dart') {
    return flutter_boilerplate_tool.generateMainFile(
      project.projectImportName,
      project.currentTheme,
    );
  } else if (fileName.endsWith('_screen.dart')) {
    return flutter_boilerplate_tool.generateScreenFile(
      fileName,
    );
  } else {
    return '';
  }
}


// String getFileContent(
//     String fileName,
//     String importPackage,
//     String lightPrimaryColor,
//     String lightPrimaryVariantColor,
//     String lightTextColor,
//     String darkPrimaryColor,
//     String darkPrimaryVariantColor,
//     String darkTextColor,
//     String currentTheme,
//     List<String> screens) {
//   switch (fileName) {
//     case 'theme_colors.dart':
//       return '''
//       import 'package:flutter/material.dart';

//       abstract class ThemeColors {
//         Color primaryColor = const Color(0xFF$lightPrimaryColor);
//         Color primaryVariantColor = const Color(0xFF$lightPrimaryVariantColor);
//         Color white = const Color(0xFFFFFFFF);
//         Color blue = const Color(0xFF4a85fd);
//         Color textColor = const Color(0xFF$lightTextColor);

//         static ThemeColors getThemeColors(BuildContext context) {
//           final Brightness brightness = Theme.of(context).brightness;
//           if (brightness == Brightness.dark) {
//             return DarkThemeColors();
//           } else {
//             return LightThemeColors();
//           }
//         }
//       }

//       class LightThemeColors extends ThemeColors {
//         LightThemeColors() {
//           super.primaryColor = const Color(0xFF$lightPrimaryColor);
//           super.primaryVariantColor = const Color(0xFF$lightPrimaryVariantColor);
//           super.white = const Color(0xFFFFFFFF);
//           super.blue = const Color(0xFF4a85fd);
//           super.textColor = const Color(0xFF$lightTextColor);
//         }
//       }

//       class DarkThemeColors extends ThemeColors {
//         DarkThemeColors() {
//           super.primaryColor = const Color(0xFF$darkPrimaryColor);
//           super.primaryVariantColor = const Color(0xFF$darkPrimaryVariantColor);
//           super.white = const Color(0xFFFFFFFF);
//           super.blue = const Color(0xFF4a85fd);
//           textColor = const Color(0xFF$darkTextColor);
//         }
//       }
//       ''';

//     case 'theme_builder.dart':
//       return '''
//       import 'package:flutter/material.dart';
//       import '$importPackage/theme/theme_colors.dart';
//       import 'package:google_fonts/google_fonts.dart';

//       class ThemeBuilder {
//         static ThemeData buildTheme(BuildContext context, Brightness brightness) {
//           ThemeColors themeColors = LightThemeColors();
//           if (brightness == Brightness.dark) {
//             themeColors = DarkThemeColors();
//           }

//           return ThemeData(
//             useMaterial3: true,
//             splashColor: themeColors.primaryColor,
//             colorScheme: ColorScheme.fromSeed(
//               seedColor: themeColors.primaryColor,
//               brightness: brightness,
//             ),
//             textTheme: GoogleFonts.interTextTheme(
//               Theme.of(context).textTheme,
//             ).apply(
//               bodyColor: themeColors.textColor,
//               displayColor: themeColors.textColor,
//             ),
//             iconTheme: IconThemeData(
//               color: themeColors.primaryVariantColor,
//               size: 30,
//             ),
//             iconButtonTheme: IconButtonThemeData(
//               style: IconButton.styleFrom(
//                 foregroundColor: themeColors.primaryColor,
//                 backgroundColor: themeColors.primaryVariantColor,
//                 fixedSize: const Size.square(60),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             inputDecorationTheme: InputDecorationTheme(
//               filled: true,
//               fillColor: themeColors.primaryColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: themeColors.primaryColor,
//                 foregroundColor: themeColors.primaryVariantColor,
//                 textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 backgroundColor: themeColors.primaryColor,
//                 foregroundColor: themeColors.primaryVariantColor,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           );
//         }
//       }
//       ''';

//     case 'gap.dart':
//       return '''
//       import 'package:flutter/material.dart';

//       SizedBox vGap(double height) => SizedBox(height: height);

//       SizedBox hGap(double width) => SizedBox(width: width);
//       ''';

//     case 'route_path.dart':
//       return '''
//       class RoutePath {
//         static const String splash = '/';
//         static const String login = '/login';
//         static const String home = '/home';
//       }
//       ''';

//     case 'route_generator.dart':
//       return '''
//       import 'package:flutter/material.dart';
//       import '$importPackage/routes/route_path.dart';
//       ${screens.map((screen) => "import '$importPackage/screens/${screen.toLowerCase()}_screen.dart';").join('\n')}

//       class RoutesGenerator {
//         static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
//           switch (settings.name) {
//             case RoutePath.splash:
//               return MaterialPageRoute(builder: (_) => const SplashScreen());

//             case RoutePath.login:
//               return Material
//                return MaterialPageRoute(builder: (_) => const LoginScreen());

//                case RoutePath.home:
//                  return MaterialPageRoute(builder: (_) => const HomeScreen());

//                default:
//                  return MaterialPageRoute(builder: (_) => const NotFoundScreen());
//              }
//            }
//          }

//          class NotFoundScreen extends StatelessWidget {
//            const NotFoundScreen({super.key});
//            @override
//            Widget build(BuildContext context) {
//              return const Scaffold(
//                body: Center(
//                  child: Text('Page not found'),
//                ),
//              );
//            }
//          }
//          ''';

//     case 'main.dart':
//       return '''
//        import 'package:flutter/material.dart';
//        import '$importPackage/theme/theme_builder.dart';
//        import '$importPackage/routes/routes_generator.dart';

//        void main() {
//          runApp(const MyApp());
//        }

//        class MyApp extends StatelessWidget {
//          const MyApp({super.key});

//          @override
//          Widget build(BuildContext context) {
//            return MaterialApp(
//              title: 'Flutter Demo',
//              theme: ThemeBuilder.buildTheme(context, Brightness.${currentTheme.toLowerCase()}),
//              onGenerateRoute: RoutesGenerator.onGenerateRoute,
//            );
//          }
//        }
//        ''';

//     default:
//       if (fileName.endsWith('_screen.dart')) {
//         final screenName = fileName
//             .replaceAll('_screen.dart', '')
//             .split('_')
//             .map((str) => str[0].toUpperCase() + str.substring(1))
//             .join('');
//         return '''
//          import 'package:flutter/material.dart';

//          class ${screenName}Screen extends StatefulWidget {
//            const ${screenName}Screen({super.key});

//            @override
//            State<${screenName}Screen> createState() => _${screenName}ScreenState();
//          }

//          class _${screenName}ScreenState extends State<${screenName}Screen> {
//            @override
//            Widget build(BuildContext context) {
//              return const Scaffold(
//                body: Center(
//                  child: Text('${screenName}Screen'),
//                ),
//              );
//            }
//          }
//          ''';
//       }
//       return '';
//   }
// }
