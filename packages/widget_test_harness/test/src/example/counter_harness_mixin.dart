import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

import 'example_model.dart';

int singleton = 0;
base mixin CounterHarnessMixin on FlutterTestHarness {
  CounterModel counter = CounterModel();
  @override
  Widget setupWidgetTree(Widget child) {
    return super.setupWidgetTree(Provider.value(value: counter, child: child));
  }

  @override
  Future<void> teardown() {
    singleton = 0;
    return super.teardown();
  }
}

extension ExampleGiven on Given<CounterHarnessMixin> {
  void countIs(int value) {
    harness.counter.count.value = value;
  }

  void countSingletonIs(int value) {
    singleton = value;
  }
}

extension ExampleWhen on When<CounterHarnessMixin> {
  void throwsSomeException() {
    throw Exception();
  }
}

extension ExampleThen on Then<CounterHarnessMixin> {
  void countEquals(int equal) {
    expect(harness.counter.count.value, equals(equal));
  }

  void countSingletonIs(int equal) {
    expect(singleton, equal);
  }
}
