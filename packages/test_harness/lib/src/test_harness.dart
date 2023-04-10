import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Used to setup zones
/// All objects in zoneValue map are merged then passed into a single zoneValue in a single [runZoned]
/// httpOverrides are passed into [HttpOverrides.runWithHttpOverrides]
/// only a single [ZoneSetup] can have a httpOverride value be nonnull
///
class ZoneSetup {
  const ZoneSetup({this.zoneValues, this.httpOverrides});
  final Map<Object?, Object?>? zoneValues;
  final HttpOverrides? httpOverrides;
}

/// Base class for [UnitTestHarness] and [WidgetTestHarness]
/// intended for mixins to conform to build up testing feature dependencies
/// ```dart
/// mixin SomeFeature on TestHarness {
///
/// }
/// ```
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

/// class to subclass for any test that does not take a [WidgetTester]
/// use UnitTestHarnessSetup to create a harness then pass it into the body of a test
/// ```dart
/// 
///  test('myTest', unitTestHarness((given,when,then) async {}))
/// final unitTestHarness = UnitTestHarnessSetup.setupHarness(MyHarness.new);
///
/// class MyHarness extends UnitTestHarness {
///
/// }
///
abstract class UnitTestHarness extends TestHarness {
  UnitTestHarness();
}

/// class to subclass for any test that takes a [WidgetTester]
/// use UnitTestHarnessSetup to create a harness then pass it into the body of a test
/// ```dart
/// 
///  testWidgets('myTest', uiHarness((given,when,then) async {}))
/// final uiHarness = WidgetTestHarnessSetup.setupHarness(MyHarness.new);
///
/// class MyHarness extends WidgetTestHarness {
///
/// }
/// ```
///

abstract class WidgetTestHarness extends TestHarness {
  WidgetTestHarness(this.tester);
  final WidgetTester tester;
}
