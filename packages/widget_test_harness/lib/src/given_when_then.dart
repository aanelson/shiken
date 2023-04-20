
/// Given class
class Given<T> {
  const Given(this.harness);

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