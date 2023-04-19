import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

///
/// This class and the subclasses exist to simplify the creation of test harness.
/// Primarily exists for unique types for Given,When,Then between Widget/ Unit test harness
///
/// used to create a Function with a harness.  The [Given], [When], [Then] are then created based on which harness setup is called and if the [TestHarness] is the appropriate subclass
/// For Example, [UnitTestHarness] takes a harness that is subclassed from [UnitTestHarness] and returns [UnitTestGiven], [UnitTestWhen] and [UnitTestThen]
/// This allows a single mixin to support both widget and unit tests but only expose the appropriate methods for the type of test.
///
/// see [UnitTestHarness] and [WidgetTestHarness]
///

abstract class HarnessSetup<H extends FlutterTestHarness, G extends Given<H>,
    W extends When<H>, T extends Then<H>> {
  @protected
  G createGiven(H harness);
  @protected
  W createWhen(H harness);
  @protected
  T createThen(H harness);

  Future<void> setupHarnessAndExecute(
      H harness, ClassHarnessCallback<H, G, W, T> callback) async {
    await harness.setup();

    var callbackRan = 0;
    Future<void> runGivenWhenThen() async {
      final given = createGiven(harness);
      final when = createWhen(harness);
      final then = createThen(harness);
      await callback(given, when, then);
      callbackRan++;
    }
    await harness.setupZones(runGivenWhenThen);

    assert(callbackRan == 1, 'given, when, then callback was not executed $callbackRan times');
    harness.dispose();
  }
}

/// This function is used to generate a function to pass into a unit test
/// From there you can use the [Given], [When], [Then] to compose the test case

typedef ClassHarnessCallback<H, G extends Given<H>, W extends When<H>,
        T extends Then<H>>
    = Future<void> Function(G, W, T);
