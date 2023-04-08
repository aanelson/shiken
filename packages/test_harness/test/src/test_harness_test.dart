// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:test_harness/test_harness.dart';

void main() {
  group('TestHarness', () {
    test('test harness can setup values', harness((given, when, then) async {
      then
        ..setupValueIsTrue()
        ..timesSetupRan(1);
    }));
  });
}

class Harness extends TestHarness with SetupValue1, SetupValue2 {}

mixin SetupValue1 on TestHarness {
  @override
  Future<void> setup() {
    timesSetupRan++;
    return super.setup();
  }

  int timesSetupRan = 0;
}
mixin SetupValue2 on TestHarness {
  @override
  Future<void> setup() {
    ranSetup = true;
    return super.setup();
  }

  bool ranSetup = false;
}

final harness = setupHarness(Harness.new);

extension on Then<SetupValue2> {
  void setupValueIsTrue() {
    expect(this.harness.ranSetup, true);
  }
}

extension on Then<SetupValue1> {
  void timesSetupRan(int times) => expect(this.harness.timesSetupRan, times);
}
