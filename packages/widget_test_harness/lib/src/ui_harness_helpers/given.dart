import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../given_when_then.dart';
import '../test_harness.dart';

extension CommonGivenWidgetTestHelpers on WidgetGiven<WidgetTestHarness> {
  /// passthrough for [WidgetTester.pumpWidget]
  Future<void> pumpWidget(
    Widget widget, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) =>
      tester.pumpWidget(widget, duration, phase);
}
