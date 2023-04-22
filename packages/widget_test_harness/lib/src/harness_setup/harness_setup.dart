import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

///
/// This class is used to generate a function that has the callback with the appropriate given,when,then
/// Used to generate unique types for Given,When,Then between Widget/ Unit test harness so mixins can provide targeted extensions
///
/// The [Given], [When], [Then] are then created based on which harness setup is called
/// For Example, [HarnessSetup.setupHarness] takes a harness that does not have a [WidgetTester] and returns [Given], [When] and [Then]
///
/// see [setupWidgetHarness] and [setupHarness] on actual usage
///

class HarnessSetup<H extends FlutterTestHarness> {
  static Future<void> Function() Function(ClassHarnessCallback<H> callback)
      setupHarness<H extends UnitTestHarness>(H Function() createHarness) {
    Future<void> Function() privateHarness(ClassHarnessCallback<H> callback) {
      return () async {
        final harness = createHarness();
        final setup = HarnessSetup<H>();
        await setup.setupHarnessAndExecute(harness, callback);
      };
    }

    return privateHarness;
  }

  static WidgetTesterReturn Function(ClassHarnessCallback<H> callback)
      setupWidgetHarness<H extends WidgetTestHarness>(
          H Function(WidgetTester tester) createHarness) {
    WidgetTesterReturn privateHarness(ClassHarnessCallback<H> callback) {
      return (tester) async {
        final harness = createHarness(tester);
        final setup = HarnessSetup<H>();
        await setup.setupHarnessAndExecute(harness, callback);
      };
    }

    return privateHarness;
  }

  Future<void> setupHarnessAndExecute(
      H harness, ClassHarnessCallback<H> callback) async {
    await harness.setup();

    var callbackRan = 0;
    Future<void> runGivenWhenThen() async {
      final when = When(harness);
      await callback(Given(harness), when, Then(harness));
      callbackRan++;
    }

    await harness.setupZones(runGivenWhenThen);

    assert(callbackRan == 1,
        'given, when, then callback was not executed $callbackRan times');
    harness.dispose();
  }
}

/// This function is used to generate a function to pass into a unit test
/// From there you can use the [Given], [When], [Then] to compose the test case

typedef ClassHarnessCallback<H> = Future<void> Function(
    Given<H>, When<H>, Then<H>);

typedef WidgetTesterReturn = Future<void> Function(WidgetTester tester);
