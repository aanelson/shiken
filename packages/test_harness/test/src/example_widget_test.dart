import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_harness/test_harness.dart';

import 'example_unit_test.dart';

class _ExampleWidgetTestHarness extends WidgetTestHarness {
  _ExampleWidgetTestHarness(super.tester);
}

extension ExampleGiven on Given<_ExampleWidgetTestHarness> {
  Future<void> preCondition() async {
    await harness.tester.pumpWidget(harness.insertWidget(const WidgetUnderTest()));
  }
}

extension ExampleWhen on When<_ExampleWidgetTestHarness> {
  Future<void> userPerformsSomeAction() async {
    await harness.tester.tap(find.text('0'));
  }
}

extension ExampleThen on Then<_ExampleWidgetTestHarness> {
  Future<void> makeSomeAssertion() async {
    await harness.tester.pump();
    expect(find.text('1'), findsOneWidget);
  }
}

class WidgetUnderTest extends StatelessWidget {
  const WidgetUnderTest({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          counter.count++;
        },
        child: Text(counter.count.toString()),
      ),
    );
  }
}
