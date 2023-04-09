import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'given_when_then.dart';

Future<void> Function() Function(TestHarnessCallback<T> callback)
    setupHarness<T extends TestHarness>(T Function() createHarness) {
  Future<void> Function() privateHarness(TestHarnessCallback<T> callback) {
    return () async {
      final harness = createHarness();
      await harness.setup();

      final zones = <ZoneSetup>[];
      harness.zoneSetup(zones);
      var callbackRan = false;
      final httpOverrides =
          zones.map((e) => e.httpOverrides).whereNotNull().toList();
      final zoneValues = zones
          .map((e) => e.zoneValues)
          .whereNotNull()
          .fold(<Object?, Object?>{}, (previousValue, element) {
        return previousValue..addAll(element);
      });
      assert(
        httpOverrides.length <= 1,
        'There should only a single httpOverride being used',
      );
      Future<void> runGivenWhenThen() async {
        await givenWhenThen(harness, callback);
        callbackRan = true;
      }

      await runZoned(() {
        if (httpOverrides.isNotEmpty) {
          return HttpOverrides.runWithHttpOverrides(
            runGivenWhenThen,
            httpOverrides.single,
          );
        } else {
          return runGivenWhenThen();
        }
      }, zoneValues: zoneValues);
      assert(callbackRan, 'given, when, then callback was not executed');
      // zones.first.zoneSetup(() => givenWhenThen(harness, callback));
      // await runZoned(() => runZoned(() => givenWhenThen(harness, callback)));
      harness.dispose();
    };
  }

  return privateHarness;
}

// Future<void> Function(WidgetTester tester) Function(
//         TestHarnessCallback<T> callback)
//     setupWidgetHarness<T extends WidgetTestHarness>(
//         T Function(WidgetTester widgetTester) createHarness) {
//   Future<void> Function(WidgetTester tester) privateHarness(
//       TestHarnessCallback<T> callback) {
//     return (tester) async {
//       final harness = createHarness(tester);
//       await harness.setup();
//       final zones = <ZoneSetup>[];
//       harness.zoneSetup(zones);
//       zones.firstWhereOrNull();

//       await runZoned(() => HttpOverrides.runWithHttpOverrides(
//             () => givenWhenThen(harness, callback),
//           ));
//       harness.dispose();
//     };
//   }

//   return privateHarness;
// }

typedef TestHarnessCallback<T> = Future<void> Function(
    Given<T>, When<T>, Then<T>);

Future<void> givenWhenThen<T>(T harness, TestHarnessCallback<T> callback) =>
    callback(Given(harness), When(harness), Then(harness));

class ZoneSetup {
  const ZoneSetup({this.zoneValues, this.httpOverrides});
  final Map<Object?, Object?>? zoneValues;
  final HttpOverrides? httpOverrides;
}

abstract class TestHarness {
  @mustCallSuper
  void zoneSetup(List<ZoneSetup> zones) {}

  @mustCallSuper
  Future<void> setup() async {}

  @mustCallSuper
  void dispose() {}

  @mustCallSuper
  Widget insertWidget(Widget child) => child;
}

/// {@template test_harness}
/// Helps setup a test harness
/// {@endtemplate}
abstract class UnitTestHarness extends TestHarness {
  UnitTestHarness();

  /// {@macro test_harness}
}

abstract class WidgetTestHarness extends TestHarness {
  WidgetTestHarness(this.tester);
  final WidgetTester tester;
}
