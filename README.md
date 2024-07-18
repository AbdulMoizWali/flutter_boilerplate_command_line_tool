# Flutter Boilerplate Tool

## Introduction

`flutter_boilerplate_tool` is a command-line utility designed to simplify the creation of boilerplate code for Flutter projects. It prompts users for theme settings and screen names, generating the necessary files and directory structure for a new Flutter project.

## Installation

To install the `flutter_boilerplate_tool` globally, use the following command:

```
dart pub global activate flutter_boilerplate_tool
```

## Usage

To run the tool, navigate to your Flutter project directory and use:

```
dart run flutter_boilerplate_tool
```

### Usage Example

```
dart run flutter_boilerplate_tool
```

You will be prompted to configure your project:

```
NOTE: This will override main and some other files. You should run this first.
Do you want to continue? (y/N): y
Project Import Package name (like 'flutter_demo_app') : flutter_app

============ Light Theme ===========

Note: Use hex color code without #
like (eeeeee, ffffff, 000000)

LightPrimaryColor: eeeeee
LightPrimaryVariantColor: eaf1ff
LightTextColor: 000000

============ Dark Theme ===========
DarkPrimaryColor: 3B3B3B
DarkPrimaryVariantColor: D4D4D4
DarkTextColor: DADADA

Current Theme? (light, dark): light

============ Screens ============
Note: No capital letter and no special character except '_' and no need to add "_screen" suffix.
Example: home, profile, settings
Screen1: splash
Add more screens? (y/N): y
Screen2: login
Add more screens? (y/N): y
Screen3: home
Add more screens? (y/N): N

Boilerplate code created successfully.

```

This will generate the necessary file structure and boilerplate code based on your inputs.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request on the [GitHub repository](https://github.com/AbdulMoizWali/flutter_boilerplate_command_line_tool).

## License

This project is licensed under the MIT License. See the LICENSE file for details.
