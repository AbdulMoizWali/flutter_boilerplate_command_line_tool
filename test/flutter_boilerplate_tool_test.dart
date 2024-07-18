import 'package:flutter_boilerplate_tool/flutter_boilerplate_tool.dart';
import 'package:test/test.dart';

void main() {
  test('getScreenNameFromFilename', () {
    expect(getScreenNameFromFilename('home_screen.dart'), 'HomeScreen');
  });
}
