import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

import '../given_when_then.dart';
import '../test_harness.dart';
extension CommonWhenWidgetTestHelpers on WidgetWhen<WidgetTestHarness> {
  /// passthrough for [WidgetTester.pump]
  Future<void> pump(
          [Duration? duration,
          EnginePhase phase = EnginePhase.sendSemanticsUpdate]) =>
      tester.pump(duration, phase);

  /// passthrough for [WidgetTester.pumpAndSettle]
  Future<int> pumpAndSettle([
    Duration duration = const Duration(milliseconds: 100),
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
    Duration timeout = const Duration(minutes: 10),
  ]) =>
      tester.pumpAndSettle(duration, phase, timeout);

  /// passthrough for [WidgetTester.ensureVisible]
  Future<void> ensureVisible(Finder finder) => tester.ensureVisible(finder);

  /// passthrough for [WidgetTester.idle]
  Future<void> idle() => tester.idle();

  /// passthrough for [WidgetTester.tap]
  Future<void> tap(
    Finder finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) =>
      tester.tap(finder,
          pointer: pointer, buttons: buttons, warnIfMissed: warnIfMissed);
}
