import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

/// Faciliates the creation of a [WidgetTestHarness] function for use in a widgetTest
///
/// ```dart
/// class MyHarness extends UnitTestHarness {
///
/// }
///
/// ```
///
typedef WidgetTesterReturn = Future<void> Function(WidgetTester tester);

class WidgetTestHarnessSetup<H extends WidgetTestHarness>
    extends HarnessSetup<H, WidgetGiven<H>, WidgetWhen<H>, WidgetThen<H>> {
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
        await setup.setupHarnessAndExcute(harness, callback);
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
