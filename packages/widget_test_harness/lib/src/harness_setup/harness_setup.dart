part of '../test_harness.dart';

///
/// Used to generate a function that has the callback with the appropriate given,when,then
/// Provides common setup functionality that mixins can use
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
        harness._validator.validateDartTest();
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
        harness._validator.validateWidgetTest();
      };
    }

    return privateHarness;
  }

  ///
  Future<void> setupHarnessAndExecute(
      H harness, ClassHarnessCallback<H> callback) async {
    await harness.setup();

    Future<void> runGivenWhenThen() async {
      try {
        await callback(
            PublicGiven(harness), PublicWhen(harness), PublicThen(harness));
      } finally {
        harness._validator.zoneCalled++;
        await harness.teardown();
      }
    }

    await harness.setupZones(runGivenWhenThen);
  }
}

/// This function is used to generate a function to pass into a unit test
/// From there you can use the [Given], [When], [Then] to compose the test case

typedef ClassHarnessCallback<T extends FlutterTestHarness> = Future<void>
    Function(PublicGiven<T>, PublicWhen<T>, PublicThen<T>);

typedef WidgetTesterReturn = Future<void> Function(WidgetTester tester);
