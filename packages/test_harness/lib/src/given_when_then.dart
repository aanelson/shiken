import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';

/// Base class for Given.  Use extentions on this to share code between unit and Widget tests
class Given<T> {
  const Given(this.harness);

  final T harness;
}

/// Base class for When.  Use extentions on this to share code between unit and Widget tests
class When<T> {
  const When(this.harness);
  final T harness;
}

/// Base class for Then. Use extensions on this to share code between unit and Widget tests.
class Then<T> {
  const Then(this.harness);
  final T harness;
}

/// Given class for writing helper methods for Unit test
class UnitTestGiven<T extends UnitTestHarness> extends Given<T> {
  const UnitTestGiven(super.harness);
}

/// When class for writing helper methods for Unit test
class UnitTestWhen<T extends UnitTestHarness> extends When<T> {
  const UnitTestWhen(super.harness);
}

/// Then class for writing helper methods for Unit test
class UnitTestThen<T extends UnitTestHarness> extends Then<T> {
  const UnitTestThen(super.harness);
}

/// Given class for writing helper methods for widget tests
class WidgetGiven<T extends WidgetTestHarness> extends Given<T> {
  const WidgetGiven(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}

/// When class for writing helper methods for widget tests
class WidgetWhen<T extends WidgetTestHarness> extends When<T> {
  const WidgetWhen(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}

/// Then class for writing helper methods for widget tests
class WidgetThen<T extends WidgetTestHarness> extends Then<T> {
  const WidgetThen(super.harness);
  @protected
  WidgetTester get tester => harness.tester;
}
