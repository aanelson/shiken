import 'package:shiken_test_harness/test_harness.dart';

/// Used to create a Unit test harness
/// 
///

class UnitTestHarnessSetup<H extends UnitTestHarness> extends HarnessSetup<H,
    UnitTestGiven<H>, UnitTestWhen<H>, UnitTestThen<H>> {
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
        await setup.setupHarnessAndExcute(harness, callback);
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
