import 'package:flutter_test/flutter_test.dart';

import 'counter_harness_mixin.dart';
import 'example_unit_harness.dart';
import 'example_widget_harness.dart';

void main() {
  group('example unit tests', () {
    test('testCounter', unitTestHarness((given, when, then) async {
      given.countIs(1);
      when.countIncreaseByOne();
      then.countEquals(2);
    }));
  });
  group('example widget tests', () {
    testWidgets('test Counter', uiHarness((given, when, then) async {
      given.countIs(1);
      await given.setupWidget();
      await when.userPerformsSomeAction();
      await then.findsWidgetText();
      then.countEquals(2);
    }));
  });
}
