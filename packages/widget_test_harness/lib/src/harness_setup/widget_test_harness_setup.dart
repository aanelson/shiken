import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

/// Facilitates the creation of a function for use in a widgetTest
///
/// ```dart
/// class MyHarness extends WidgetTestHarness {
///
/// }
/// final harness = WidgetTestHarnessSetup.setupHarness(MyHarness.new);
/// ```
///
class WidgetTestHarnessSetup<H extends WidgetTestHarness>
    extends HarnessSetup<H, WidgetGiven<H>, WidgetWhen<H>, WidgetThen<H>> {
  /// creates a function that uses a [WidgetTestHarness] and returns a callback with [WidgetGiven], [WidgetWhen] and [WidgetThen]
  static WidgetTesterReturn Function(
      ClassHarnessCallback<H, WidgetGiven<H>, WidgetWhen<H>, WidgetThen<H>>
          callback) setupHarness<H extends WidgetTestHarness>(
      H Function(WidgetTester tester) createHarness) {
    WidgetTesterReturn privateHarness(
        ClassHarnessCallback<H, WidgetGiven<H>, WidgetWhen<H>, WidgetThen<H>>
            callback) {
      return (tester) async {
        final harness = createHarness(tester);
        final setup = WidgetTestHarnessSetup<H>();
        await setup.setupHarnessAndExecute(harness, callback);
      };
    }

    return privateHarness;
  }

  @override
  WidgetGiven<H> createGiven(H harness) => WidgetGiven(harness);

  @override
  WidgetThen<H> createThen(H harness) => WidgetThen(harness);

  @override
  WidgetWhen<H> createWhen(H harness) => WidgetWhen(harness);
}

typedef WidgetTesterReturn = Future<void> Function(WidgetTester tester);
