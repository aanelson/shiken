// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

void main() {
  group('TestHarness', () {
    test(
      'test harness can setup values',
      harness((given, when, then) async {
        then
          ..setupValueIsTrue()
          ..timesSetupRan(1);
      }),
    );
    test('zone has values', harness((given, when, then) async {
      then.zoneHasValues();
    }));
  });
}

final class Harness extends UnitTestHarness with SetupValue1, SetupValue2 {}

base mixin SetupValue1 on FlutterTestHarness {
  @override
  Future<void> setupZones(Future<void> Function() child) {
    return runZoned(
      () => super.setupZones(child),
      zoneValues: {#setupValue1Key: 100},
    );
  }

  @override
  Future<void> setup() {
    timesSetupRan++;
    return super.setup();
  }

  int timesSetupRan = 0;
}
base mixin SetupValue2 on FlutterTestHarness {
  @override
  Future<void> setup() {
    ranSetup = true;
    return super.setup();
  }

  @override
  Future<void> setupZones(Future<void> Function() child) {
    return runZoned(
      () => super.setupZones(child),
      zoneValues: {#setupValue2Key: 200},
    );
  }

  bool ranSetup = false;
}
final harness = HarnessSetup.setupHarness(Harness.new);

extension on Then<Harness> {
  void zoneHasValues() {
    expect(Zone.current[#setupValue1Key], 100);
    expect(Zone.current[#setupValue2Key], 200);
  }
}

extension on Then<SetupValue2> {
  void setupValueIsTrue() {
    expect(this.harness.ranSetup, true);
  }
}

extension on Then<SetupValue1> {
  void timesSetupRan(int times) => expect(this.harness.timesSetupRan, times);
}
