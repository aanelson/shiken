import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:test_harness/test_harness.dart';

///
/// This class and the subclasses exist to simplify the creation of test harness.
/// Primarily exists for unique types for Given,When,Then between Widget/ Unit test harness
///
/// [UnitTestHarness] and [WidgetTestHarness]
///

abstract class HarnessSetup<H extends TestHarness, G extends Given<H>,
    W extends When<H>, T extends Then<H>> {
  @protected
  G createGiven(H harness);
  @protected
  W createWhen(H harness);
  @protected
  T createThen(H harness);

  Future<void> setupHarnessAndExcute(
      H harness, ClassHarnessCallback<H, G, W, T> callback) async {
    await harness.setup();

    final zones = <ZoneSetup>[];
    harness.zoneSetup(zones);
    var callbackRan = false;
    final httpOverrides =
        zones.map((e) => e.httpOverrides).whereNotNull().toList();
    final zoneValues = zones
        .map((e) => e.zoneValues)
        .whereNotNull()
        .fold(<Object?, Object?>{}, (previousValue, element) {
      return previousValue..addAll(element);
    });
    assert(
      httpOverrides.length <= 1,
      'There should only a single httpOverride being used',
    );
    Future<void> runGivenWhenThen() async {
      final given = createGiven(harness);
      final when = createWhen(harness);
      final then = createThen(harness);
      await callback(given, when, then);
      callbackRan = true;
    }

    await runZoned(
      () {
        if (httpOverrides.isNotEmpty) {
          return HttpOverrides.runWithHttpOverrides(
            runGivenWhenThen,
            httpOverrides.single,
          );
        } else {
          return runGivenWhenThen();
        }
      },
      zoneValues: zoneValues,
    );
    assert(callbackRan, 'given, when, then callback was not executed');
    harness.dispose();
  }
}

/// This function is used to generate a function to pass into a unit test
/// From there you can use the [Given], [When], [Then] to compose the test case

/// This function is used to generate a function to pass into a widget test
/// From there you can use the [Given], [When], [Then] to compose the test case

typedef ClassHarnessCallback<H, G extends Given<H>, W extends When<H>,
        T extends Then<H>>
    = Future<void> Function(G, W, T);
