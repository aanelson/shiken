import 'test_harness.dart';

abstract class GWTBase<T extends FlutterTestHarness> {
  const GWTBase(this.harness);
  final T harness;
}

/// Given class
class Given<T extends FlutterTestHarness> extends GWTBase<T> {
  const Given(super.harness);
}

/// When class
class When<T extends FlutterTestHarness> extends GWTBase<T> {
  const When(super.harness);
}

/// Then class
class Then<T extends FlutterTestHarness> extends GWTBase<T> {
  const Then(super.harness);
}
