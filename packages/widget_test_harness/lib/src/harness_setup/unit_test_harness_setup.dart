import 'package:widget_test_harness/widget_test_harness.dart';

/// Facilitates the creation of a function for use in a widgetTest
///
/// ```dart
/// class MyHarness extends UnitTestHarness {
///
/// }
/// final harness = UnitTestHarnessSetup.setupHarness(MyHarness.new);
/// ```
///

class UnitTestHarnessSetup<H extends UnitTestHarness> extends HarnessSetup<H,
    UnitTestGiven<H>, UnitTestWhen<H>, UnitTestThen<H>> {

    /// creates a function that uses a [UnitTestHarness] and returns a callback with [UnitTestGiven], [UnitTestWhen] and [UnitTestThen]

  static Future<void> Function() Function(
      ClassHarnessCallback<H, UnitTestGiven<H>, UnitTestWhen<H>,
              UnitTestThen<H>>
          callback) setupHarness<H extends UnitTestHarness>(
      H Function() createHarness) {
    Future<void> Function() privateHarness(
        ClassHarnessCallback<H, UnitTestGiven<H>, UnitTestWhen<H>,
                UnitTestThen<H>>
            callback) {
      return () async {
        final harness = createHarness();
        final setup = UnitTestHarnessSetup<H>();
        await setup.setupHarnessAndExecute(harness, callback);
      };
    }

    return privateHarness;
  }

  @override
  UnitTestGiven<H> createGiven(H harness) => UnitTestGiven(harness);

  @override
  UnitTestThen<H> createThen(H harness) => UnitTestThen(harness);

  @override
  UnitTestWhen<H> createWhen(H harness) => UnitTestWhen(harness);
}
