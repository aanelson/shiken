import 'package:flutter_test/flutter_test.dart';

/// abstraction so mixins can be written to support dart tests and widget tests
/// uses [pump], [pumpAndSettle], and [idle] in widget tests.  Uses [Future.value] and [Future.microtask]
/// for unit tests

abstract class CommonTester {
  Future<void> pumpOrWait([Duration? duration]);
  Future<void> pumpAndSettleOrWait([Duration? duration]);
  Future<void> idle();
}

class UnitCommonTester implements CommonTester {
  @override
  Future<void> idle() => Future.microtask(() {});

  @override
  Future<void> pumpAndSettleOrWait([Duration? duration]) => Future.value();
  @override
  Future<void> pumpOrWait([Duration? duration]) => Future.value();
}

class WidgetCommonTester implements CommonTester {
  WidgetCommonTester(this.tester);
  final WidgetTester tester;

  @override
  Future<void> idle() => tester.idle();

  @override
  Future<void> pumpAndSettleOrWait([Duration? duration]) =>
      tester.pumpAndSettle(duration ?? const Duration(milliseconds: 100));

  @override
  Future<void> pumpOrWait([Duration? duration]) => tester.pump(duration);
}
