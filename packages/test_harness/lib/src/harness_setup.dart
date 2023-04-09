import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_harness/test_harness.dart';

abstract class HarnessSetup<H extends TestHarness, G extends Given<H>,
    W extends When<H>, T extends Then<H>> {
  const HarnessSetup();
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

class UnitTestSetup<H extends UnitTestHarness>
    extends HarnessSetup<H, Given<H>, When<H>, Then<H>> {
  static Future<void> Function() Function(
          ClassHarnessCallback<H, Given<H>, When<H>, Then<H>> callback)
      setupHarness<H extends UnitTestHarness>(H Function() createHarness) {
    Future<void> Function() privateHarness(
        ClassHarnessCallback<H, Given<H>, When<H>, Then<H>> callback) {
      return () async {
        final harness = createHarness();
        final setup = UnitTestSetup<H>();
        await setup.setupHarnessAndExcute(harness, callback);
      };
    }

    return privateHarness;
  }

  @override
  Given<H> createGiven(H harness) => UnitTestGiven(harness);

  @override
  Then<H> createThen(H harness) => UnitTestThen(harness);

  @override
  When<H> createWhen(H harness) => UnitTestWhen(harness);
}

class WidgetTestSetup<H extends WidgetTestHarness>
    extends HarnessSetup<H, Given<H>, When<H>, Then<H>> {
  static Future<void> Function(WidgetTester tester) Function(
          ClassHarnessCallback<H, Given<H>, When<H>, Then<H>> callback)
      setupHarness<H extends WidgetTestHarness>(
          H Function(WidgetTester tester) createHarness) {
    Future<void> Function(WidgetTester tester) privateHarness(
        ClassHarnessCallback<H, Given<H>, When<H>, Then<H>> callback) {
      return (tester) async {
        final harness = createHarness(tester);
        final setup = WidgetTestSetup<H>();
        await setup.setupHarnessAndExcute(harness, callback);
      };
    }

    return privateHarness;
  }

  @override
  Given<H> createGiven(H harness) => WidgetGiven(harness);

  @override
  Then<H> createThen(H harness) => WidgetThen(harness);

  @override
  When<H> createWhen(H harness) => WidgetWhen(harness);
}

/// This function is used to generate a function to pass into a unit test
/// From there you can use the [Given], [When], [Then] to compose the test case

/// This function is used to generate a function to pass into a widget test
/// From there you can use the [Given], [When], [Then] to compose the test case

typedef ClassHarnessCallback<H, G extends Given<H>, W extends When<H>,
        T extends Then<H>>
    = Future<void> Function(Given<H>, When<H>, Then<H>);
