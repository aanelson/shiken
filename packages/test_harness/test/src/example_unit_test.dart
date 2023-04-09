import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_harness/test_harness.dart';

class _ExampleUnitTestHarness extends UnitTestHarness
    with CounterHarnessMixin {}

extension ExampleGiven on Given<CounterHarnessMixin> {
  void preCondition() {
    harness.counter.count = 1;
  }
}

extension ExampleWhen on When<CounterHarnessMixin> {
  Future<void> userPerformsSomeAction() async {
    harness.counter.count++;
  }
}

extension ExampleThen on Then<CounterHarnessMixin> {
  void makeSomeAssertion() {
    expect(harness.counter.count, equals(2));
  }
}

mixin CounterHarnessMixin on TestHarness {
  CounterModel counter = CounterModel();
  @override
  Widget insertWidget(Widget child) {
    return super.insertWidget(Provider.value(value: counter));
  }
}

class CounterModel {
  int count = 0;
}
