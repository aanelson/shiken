import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helper_mixins.dart';

/// Base class for [UnitTestHarness] and [WidgetTestHarness]
/// intended for mixins to conform to build up testing feature dependencies see [NetworkImageMixin] for example
/// ```dart
/// mixin SomeFeature on TestHarness {
///
/// }
/// ```
abstract class FlutterTestHarness {
  /// Used so mixins can setup testing infrastructure see [SemanticTesterMixin]
  @mustCallSuper
  Future<void> setup() async {}

  /// Used so mixins can teardown testing infrastructure see [SemanticTesterMixin]
  @mustCallSuper
  void dispose() {}

  @mustCallSuper
  Widget insertWidget(Widget child) => child;

  /// used to wrap callback with [runZoned] or other test helpers that take a function.
  /// see [NetworkImageMixin] for example of setup.
  @mustCallSuper
  Future<void> setupZones(Future<void> Function() child) => child();
}

/// class to subclass for any test that does not take a [WidgetTester]
/// use [HarnessSetup.setupHarness] to create a harness then pass it into the body of a test
/// ```dart
///
///  test('myTest', unitTestHarness((given,when,then) async {}))
/// final unitTestHarness = HarnessSetup.setupHarness(MyHarness.new);
///
/// class MyHarness extends UnitTestHarness {
///
/// }
/// ```
abstract class UnitTestHarness extends FlutterTestHarness {
  UnitTestHarness();
}

/// class to subclass for any test that takes a [WidgetTester]
/// use UnitTestHarnessSetup to create a harness then pass it into the body of a test
/// ```dart
///
///  testWidgets('myTest', uiHarness((given,when,then) async {}))
/// final uiHarness = HarnessSetup.setupWidgetHarness(MyHarness.new);
///
/// class MyHarness extends WidgetTestHarness {
///
/// }
/// ```
///

abstract class WidgetTestHarness extends FlutterTestHarness {
  WidgetTestHarness(this.tester);

  /// [WidgetTester] that is passed into harness when the test is created.
  final WidgetTester tester;
}
