// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_harness/test_harness.dart';

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

class Harness extends UnitTestHarness with SetupValue1, SetupValue2 {}

mixin SetupValue1 on TestHarness {
  @override
  void zoneSetup(List<ZoneSetup> zones) {
    zones.add(ZoneSetup(zoneValues: {#setupValue1Key: 100}));
    super.zoneSetup(zones);
  }

  @override
  Future<void> setup() {
    timesSetupRan++;
    return super.setup();
  }

  int timesSetupRan = 0;
}
mixin SetupValue2 on TestHarness {
  @override
  void zoneSetup(List<ZoneSetup> zones) {
    zones.add(ZoneSetup(zoneValues: {#setupValue2Key: 100}));
    super.zoneSetup(zones);
  }

  @override
  Future<void> setup() {
    ranSetup = true;
    return super.setup();
  }

  bool ranSetup = false;
}
final harness = UnitTestHarnessSetup.setupHarness(Harness.new);

extension on Then<Harness> {
  void zoneHasValues() {
    expect(Zone.current[#setupValue1Key], 100);
    expect(Zone.current[#setupValue2Key], 100);
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
