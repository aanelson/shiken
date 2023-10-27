import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

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
  group('exception test group', () {
    // was not correctly cleaning up after excpetions
    test('exception setup', unitTestHarness((given, when, then) async {
      given.countSingletonIs(1);
      when.throwsSomeException();
    }), skip: true);
    test('exception exception does not transfer state',
        unitTestHarness((given, when, then) async {
      then.countSingletonIs(0);
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
    testGoldens('looks correct', uiHarness((given, when, then) async {
      given.countIs(1);
      await given.setupWidget();
      await then.matchesGolden('image');
    }), skip: true);
  });
}
