import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/src/image_helpers/network_image_mixin.dart';

/// Base class for [UnitTestHarness] and [WidgetTestHarness]
/// intended for mixins to conform to build up testing feature dependencies
/// ```dart
/// mixin SomeFeature on TestHarness {
///
/// }
/// ```
abstract class FlutterTestHarness {
  @mustCallSuper
  Future<void> setup() async {}

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
abstract class UnitTestHarness extends FlutterTestHarness {
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

abstract class WidgetTestHarness extends FlutterTestHarness
    with NetworkImageMixin {
  WidgetTestHarness(this.tester);

  /// [WidgetTester] that is passed into harness when the test is created.
  final WidgetTester tester;

  /// Used to mock network calls.  Required for [Image.network] and [NetworkImage] to not throw during a test
  /// see [FakeHttpClient]
  /// this is passed into [HttpOverrides] during setup and changing it in the test callback will have no effect
  /// If a test requires different return values for a network request the [HttpClient] that is passed in has to be the owner of the state change
}
