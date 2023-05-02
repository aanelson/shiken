import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'given_when_then.dart';
import 'helper_mixins.dart';

part 'harness_setup/harness_setup.dart';

/// Base class for [UnitTestHarness] and [WidgetTestHarness]
/// intended for mixins to conform to build up testing feature dependencies see [NetworkImageMixin] for example
/// ```dart
/// mixin SomeFeature on TestHarness {
///
/// }
/// ```
abstract class FlutterTestHarness {
  final _validator = _SetupValidator();

  /// Used so mixins can setup testing infrastructure see [SemanticTesterMixin] for example
  @mustCallSuper
  Future<void> setup() async {
    _validator.setupCalled++;
  }

  /// Used so mixins can teardown testing infrastructure see [SemanticTesterMixin] for example
  @mustCallSuper
  void dispose() {
    _validator.disposeCalled++;
  }

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
  Widget setupWidgetTree(Widget child) {
    _validator.widgetTreeCalled++;
    return child;
  }

  /// used to wrap callback with [runZoned] or other test helpers that take a function.
  /// see [NetworkImageMixin] for example of setup.
  ///
  /// ```dart
  /// Future<void> setupZones(Future<void> Function() child) {
  ///  return runZoned(
  ///    () => super.setupZones(child),
  ///    zoneValues: [],
  ///  );
  ///}
  /// ```
  ///
  ///
  @mustCallSuper
  Future<void> setupZones(Future<void> Function() child) {
    return child();
  }
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
///
/// See [ScreenTestHarness] for setup of widgets with mixins
///
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

class _SetupValidator {
  int setupCalled = 0;
  int disposeCalled = 0;
  int widgetTreeCalled = 0;
  int zoneCalled = 0;

  void validateDartTest() {
    expect(setupCalled, 1,
        reason:
            'setup was called $setupCalled times expected to be called once');
    expect(disposeCalled, 1,
        reason:
            'dispose was called $disposeCalled times expected to be called once');
    expect(zoneCalled, 1,
        reason: 'zone was called $zoneCalled times expected to be called once');
  }

  void validateWidgetTest() {
    validateDartTest();
    expect(widgetTreeCalled, 1,
        reason:
            '''widget tree called $widgetTreeCalled times expected to be called once,
            This is the only setup function that the widget needs to call manually.
            In the given the call should look something like below. That way mixins that are added currently and in the future
            can correctly setup the widget tree in an expected state.  

                await tester.pumpWidget(harness.setupWidgetTree(const WidgetUnderTest()));

            ''');
  }
}
