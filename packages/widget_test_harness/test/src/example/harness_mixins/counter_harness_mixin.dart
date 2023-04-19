import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

import '../example_model.dart';

mixin CounterHarnessMixin on FlutterTestHarness {
  CounterModel counter = CounterModel();
  @override
  Widget insertWidget(Widget child) {
    return super.insertWidget(Provider.value(value: counter, child: child));
  }
}

extension ExampleGiven on Given<CounterHarnessMixin> {
  void countIs(int value) {
    harness.counter.count.value = value;
  }
}

extension ExampleThen on Then<CounterHarnessMixin> {
  void countEquals(int equal) {
    expect(harness.counter.count.value, equals(equal));
  }
}
