import 'dart:io';

import 'package:flutter_boilerplate_tool/project.dart';

/// Create boilerplate code for the given [project].
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

/// Get the file content for the given [fileName] and [project].
String getFileContent(
  String fileName,
  Project project,
) {
  if (fileName == 'theme_colors.dart') {
    return generateThemeColorsFile(
      project.lightThemeColors,
      project.darkThemeColors,
    );
  } else if (fileName == 'theme_builder.dart') {
    return generateThemeBuilderFile(
      project.projectImportName,
    );
  } else if (fileName == 'gap.dart') {
    return generateGapFile();
  } else if (fileName == 'route_path.dart') {
    return generateRoutePathFile(project);
  } else if (fileName == 'route_generator.dart') {
    return generateRouteGeneratorFile(
      project,
    );
  } else if (fileName == 'main.dart') {
    return generateMainFile(
      project.projectImportName,
      project.currentTheme,
    );
  } else if (fileName.endsWith('_screen.dart')) {
    return generateScreenFile(
      fileName,
    );
  } else {
    return '';
  }
}

/// Generate the screen file with the given [filename] like 'home_screen.dart' or 'login_screen.dart'. Return 'HomeScreen' or 'LoginScreen'.
String getScreenNameFromFilename(String fileName) {
  String screen = fileName.replaceAll('_screen.dart', '');
  return getScreenNameFromScreen(screen);
}

/// Generate the screen file with the given [screenName] like 'home' or 'login'. Return 'HomeScreen' or 'LoginScreen'.
String getScreenNameFromScreen(String screen) {
  return "${screen.split('_').map((str) => str[0].toUpperCase() + str.substring(1)).join('')}Screen";
}

/// Generate the theme colors file with the given [lightThemeColors] and [darkThemeColors].
String generateThemeColorsFile(
  LightThemeColors lightThemeColors,
  DarkThemeColors darkThemeColors,
) {
  String lightPrimaryColor = lightThemeColors.primaryColor;
  String lightPrimaryVariantColor = lightThemeColors.primaryVariantColor;
  String lightTextColor = lightThemeColors.textColor;

  String darkPrimaryColor = darkThemeColors.primaryColor;
  String darkPrimaryVariantColor = darkThemeColors.primaryVariantColor;
  String darkTextColor = darkThemeColors.textColor;

  String white = lightThemeColors.white;
  String blue = lightThemeColors.blue;
  String red = lightThemeColors.red;
  String green = lightThemeColors.green;

  return '''
    import 'package:flutter/material.dart';

    abstract class ThemeColors {
      Color primaryColor = const Color(0xFF$lightPrimaryColor);
      Color primaryVariantColor = const Color(0xFF$lightPrimaryVariantColor);
      Color white = const Color(0xFF$white);
      Color blue = const Color(0xFF$blue);
      Color red = const Color(0xFF$red);
      Color green = const Color(0xFF$green);
      Color textColor = const Color(0xFF$lightTextColor);

      static ThemeColors getThemeColors(BuildContext context) {
        final Brightness brightness = Theme.of(context).brightness;
        if (brightness == Brightness.dark) {
          return DarkThemeColors();
        } else {
          return LightThemeColors();
        }
      }
    }

    class LightThemeColors extends ThemeColors {
      LightThemeColors() {
        super.primaryColor = const Color(0xFF$lightPrimaryColor);
        super.primaryVariantColor = const Color(0xFF$lightPrimaryVariantColor);
        super.white = const Color(0xFF$white);
        super.blue = const Color(0xFF$blue);
        super.red = const Color(0xFF$red);
        super.green = const Color(0xFF$green);
        super.textColor = const Color(0xFF$lightTextColor);
      }
    }

    class DarkThemeColors extends ThemeColors {
      DarkThemeColors() {
        super.primaryColor = const Color(0xFF$darkPrimaryColor);
        super.primaryVariantColor = const Color(0xFF$darkPrimaryVariantColor);
        super.white = const Color(0xFF$white);
        super.blue = const Color(0xFF$blue);
        super.red = const Color(0xFF$red);
        super.green = const Color(0xFF$green);
        textColor = const Color(0xFF$darkTextColor);
      }
    }
    ''';
}

/// Generate the theme builder file with the given [projectImportName].
String generateThemeBuilderFile(String projectImportName) {
  return '''
    import 'package:flutter/material.dart';
    import 'package:$projectImportName/theme/theme_colors.dart';
    import 'package:google_fonts/google_fonts.dart';

    class ThemeBuilder {
      static ThemeData buildTheme(BuildContext context, Brightness brightness) {
        ThemeColors themeColors = LightThemeColors();
        if (brightness == Brightness.dark) {
          themeColors = DarkThemeColors();
        }

        return ThemeData(
          useMaterial3: true,
          splashColor: themeColors.primaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: themeColors.primaryColor,
            brightness: brightness,
          ),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: themeColors.textColor,
            displayColor: themeColors.textColor,
          ),
          iconTheme: IconThemeData(
            color: themeColors.primaryVariantColor,
            size: 30,
          ),
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              foregroundColor: themeColors.primaryColor,
              backgroundColor: themeColors.primaryVariantColor,
              fixedSize: const Size.square(60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: themeColors.primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColors.primaryColor,
              foregroundColor: themeColors.primaryVariantColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: themeColors.primaryColor,
              foregroundColor: themeColors.primaryVariantColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      }
    }
    ''';
}

/// Generate the main file with the given [importPackage] and [currentTheme].
String generateMainFile(String importPackage, String currentTheme) {
  return '''
    import 'package:flutter/material.dart';
    import 'package:$importPackage/theme/theme_builder.dart';
    import 'package:$importPackage/routes/route_generator.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeBuilder.buildTheme(context, Brightness.${currentTheme.toLowerCase()}),
          onGenerateRoute: RoutesGenerator.onGenerateRoute,
        );
      }
    }
    ''';
}

/// Generate the gap file.
String generateGapFile() {
  return '''
    import 'package:flutter/material.dart';

    SizedBox vGap(double height) => SizedBox(height: height);

    SizedBox hGap(double width) => SizedBox(width: width);
    ''';
}

/// Generate the route path file with the given [project].
String generateRoutePathFile(Project project) {
  String screens = project.screens
      .map((screen) {
        return 'static const String ${screen.toLowerCase()} = \'/${screen.toLowerCase()}\';';
      })
      .toList()
      .join('\n');
  return '''
    class RoutePath {
      $screens
    }
    ''';
}

/// Generate the route generator file with the given [project].
String generateRouteGeneratorFile(Project project) {
  String projectImportName = project.projectImportName;
  List<String> screens = project.screens;

  String routes = screens.map((screen) {
    String screenName = getScreenNameFromScreen(screen);
    return '''
            case RoutePath.$screen:
              return MaterialPageRoute(builder: (_) => const $screenName());
            ''';
  }).join('\n');

  return '''
    import 'package:flutter/material.dart';
    import 'package:$projectImportName/routes/route_path.dart';
    ${screens.map((screen) => "import 'package:$projectImportName/screens/${screen.toLowerCase()}_screen.dart';").join('\n')}

    class RoutesGenerator {
      static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
        switch (settings.name) {

          $routes

          default:
            return MaterialPageRoute(builder: (_) => const NotFoundScreen());
        }
      }
    }

    class NotFoundScreen extends StatelessWidget {
      const NotFoundScreen({super.key});

      @override
      Widget build(BuildContext context) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        );
      }
    }
    ''';
}

/// Generate the screen file with the given [fileName].
String generateScreenFile(String fileName) {
  final screenName = getScreenNameFromFilename(fileName);

  return '''
    import 'package:flutter/material.dart';

    class $screenName extends StatefulWidget {
      const $screenName({super.key});

      @override
      State<$screenName> createState() => _${screenName}State();
    }

    class _${screenName}State extends State<$screenName> {
      @override
      Widget build(BuildContext context) {
        return const Scaffold(
          body: Center(
            child: Text('$screenName'),
          ),
        );
      }
    }
    ''';
}
