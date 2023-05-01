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
  /// Used so mixins can setup testing infrastructure see [SemanticTesterMixin] for example
  @mustCallSuper
  Future<void> setup() async {}

  /// Used so mixins can teardown testing infrastructure see [SemanticTesterMixin] for example
  @mustCallSuper
  void dispose() {}

  /// Allows mixins to add appropriate widgets if needed. 
  /// 
  /// Usage in given/harness for creating a test 
  /// ```dart
  ///  harness.setupWidgetTree(const MyWidget());
  /// ```
  /// 
  /// Usage in mixin
  /// ```dart
  /// Widget setupWidgetTree(Widget child) {
  ///   return super.setupWidgetTree(Provider.value(value: counter, child: child));
  ///  }
  /// ```
  /// 
  @mustCallSuper
  Widget setupWidgetTree(Widget child) => child;

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

/// class to subclass for any test that takes a [WidgetTester] see [ScreenTestHarness] for setup of widgets with mixins
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
/// 
abstract class ScreenTestHarness extends WidgetTestHarness {
  ScreenTestHarness(super.tester);
  Widget buildScreen() => setupWidgetTree(screen);

  Widget get screen;
}
