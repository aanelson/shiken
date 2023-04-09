import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class ZoneSetup {
  const ZoneSetup({this.zoneValues, this.httpOverrides});
  final Map<Object?, Object?>? zoneValues;
  final HttpOverrides? httpOverrides;
}

abstract class TestHarness {
  @mustCallSuper
  void zoneSetup(List<ZoneSetup> zones) {}

  @mustCallSuper
  Future<void> setup() async {}

  @mustCallSuper
  void dispose() {}

  @mustCallSuper
  Widget insertWidget(Widget child) => child;
}

/// {@template test_harness}
/// Helps setup a test harness
/// {@endtemplate}
abstract class UnitTestHarness extends TestHarness {
  UnitTestHarness();

  /// {@macro test_harness}
}

abstract class WidgetTestHarness extends TestHarness {
  WidgetTestHarness(this.tester);
  final WidgetTester tester;
}

extension on WidgetTestHarness {}
