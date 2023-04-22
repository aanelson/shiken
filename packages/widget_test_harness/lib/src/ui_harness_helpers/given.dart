import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/src/ui_harness_helpers/callback_base_extensions.dart';

import '../given_when_then.dart';
import '../test_harness.dart';

extension CommonGivenWidgetTestHelpers on Given<WidgetTestHarness> {
  /// passthrough for [WidgetTester.pumpWidget]
  Future<void> pumpWidget(
    Widget widget, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) =>
      tester.pumpWidget(widget, duration, phase);
}
