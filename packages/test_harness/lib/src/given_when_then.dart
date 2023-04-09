import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';

class Given<T> {
  const Given(this.harness);
  @protected
  final T harness;
}

class When<T> {
  const When(this.harness);
  @protected
  final T harness;
}

class Then<T> {
  const Then(this.harness);
  @protected
  final T harness;
}

class UnitTestGiven<T extends UnitTestHarness> extends Given<T> {
  const UnitTestGiven(super.harness);
}

class UnitTestWhen<T extends UnitTestHarness> extends When<T> {
  const UnitTestWhen(super.harness);
}

class UnitTestThen<T extends UnitTestHarness> extends Then<T> {
  const UnitTestThen(super.harness);
}

class WidgetGiven<T extends WidgetTestHarness> extends Given<T> {
  const WidgetGiven(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}

class WidgetWhen<T extends WidgetTestHarness> extends When<T> {
  const WidgetWhen(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}

class WidgetThen<T extends WidgetTestHarness> extends Then<T> {
  const WidgetThen(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}
