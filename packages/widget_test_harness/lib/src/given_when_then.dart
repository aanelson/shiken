import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';

/// base class for [Given], [When], [Then].
abstract class GWTBase<T extends FlutterTestHarness> {
  const GWTBase(this.harness);
  final T harness;
}

extension CallbackClassBaseWidgetTester on GWTBase<WidgetTestHarness> {
  @protected
  WidgetTester get tester => harness.tester;
}

/// Given class used to setup the test.
class Given<T extends FlutterTestHarness> extends GWTBase<T> {
  const Given(super.harness);
}

/// When class used for when user performs action or something happens in the system
class When<T extends FlutterTestHarness> extends GWTBase<T> {
  const When(super.harness);
}

/// Then class used for asserting behavior
class Then<T extends FlutterTestHarness> extends GWTBase<T> {
  const Then(super.harness);
}

class PublicGiven<T extends FlutterTestHarness> extends Given<T> {
  PublicGiven(super.harness);
  @protected
  @override
  T get harness;
}

class PublicWhen<T extends FlutterTestHarness> extends When<T> {
  PublicWhen(super.harness);
  @protected
  @override
  T get harness;
}

class PublicThen<T extends FlutterTestHarness> extends Then<T> {
  PublicThen(super.harness);
  @protected
  @override
  T get harness;
}
