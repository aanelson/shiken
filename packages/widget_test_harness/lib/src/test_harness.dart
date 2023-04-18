import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'http_client/http_client.dart';

/// Used to setup zones
/// All objects in zoneValue map are merged then passed into a single zoneValue in a single [runZoned]
///
class ZoneSetup {
  const ZoneSetup({this.zoneValues});
  final Map<Object?, Object?>? zoneValues;
}

/// Base class for [UnitTestHarness] and [WidgetTestHarness]
/// intended for mixins to conform to build up testing feature dependencies
/// ```dart
/// mixin SomeFeature on TestHarness {
///
/// }
/// ```
abstract class FlutterTestHarness {
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

abstract class WidgetTestHarness extends FlutterTestHarness {
  WidgetTestHarness(this.tester);

  /// [WidgetTester] that is passed into harness when the test is created.
  final WidgetTester tester;

  /// Used to mock network calls.  Required for [Image.network] and [NetworkImage] to not throw during a test
  /// see [FakeHttpClient] 
  /// this is passed into [HttpOverrides] during setup and changing it in the test callback will have no effect
  /// If a test requires different return values for a network request the [HttpClient] that is passed in has to be the owner of the state change

  HttpClient get httpClient => FakeHttpClient.transparent();
}
