import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'given_when_then.dart';

Future<void> Function() Function(UnitTestHarnessCallback<T> callback)
    setupHarness<T extends TestHarness>(T Function() createHarness) {
  final harness = createHarness();

  Future<void> Function() privateHarness(UnitTestHarnessCallback<T> callback) {
    return () async {
      await harness.setup();

      await givenWhenThenUnitTest(harness, callback);
      harness.dispose();
    };
  }

  return privateHarness;
}

typedef UnitTestHarnessCallback<T> = Future<void> Function(
    Given<T>, When<T>, Then<T>);

Future<void> givenWhenThenUnitTest<T>(
        T harness, UnitTestHarnessCallback<T> callback) =>
    callback(Given(harness), When(harness), Then(harness));

/// {@template test_harness}
/// Helps setup a test harness
/// {@endtemplate}
abstract class TestHarness {
  /// {@macro test_harness}
  const TestHarness();

  @mustCallSuper
  Future<void> setup() async {}

  @mustCallSuper
  void dispose() {}
}

abstract class WidgetTestHarness extends TestHarness {
  WidgetTester get tester;

  @mustCallSuper
  Widget insertWidget(Widget child) => child;
}
