
import 'package:flutter/foundation.dart';

/// Given class
class Given<T> {
  const Given(this.harness, this.when);
  /// when is provided in given to help facilitate more complex setups
  @protected
  final When<T> when;
  final T harness;
}

/// When class
class When<T> {
  const When(this.harness);
  final T harness;
}

/// Then class
class Then<T> {
  const Then(this.harness);
  final T harness;
}