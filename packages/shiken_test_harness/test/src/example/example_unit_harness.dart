import 'package:flutter_test/flutter_test.dart';
import 'package:shiken_test_harness/test_harness.dart';

import 'counter_harness_mixin.dart';

final unitTestHarness = UnitTestHarnessSetup.setupHarness(ExampleUnitTestHarness.new);

class ExampleUnitTestHarness extends UnitTestHarness
    with CounterHarnessMixin {}


extension ExampleWhen on When<ExampleUnitTestHarness> {
  Future<void> countIncreaseByOne() async {
    harness.counter.count.value++;
  }
}


