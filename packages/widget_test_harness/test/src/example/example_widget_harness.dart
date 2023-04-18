import 'dart:_http';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

import 'counter_harness_mixin.dart';
import 'example_model.dart';

final uiHarness =
    WidgetTestHarnessSetup.setupHarness(ExampleWidgetTestHarness.new);

class ExampleWidgetTestHarness extends WidgetTestHarness
    with CounterHarnessMixin {
  ExampleWidgetTestHarness(super.tester);

  @override
  HttpClient get httpClient => throw UnimplementedError();
}

extension ExampleGiven on WidgetGiven<ExampleWidgetTestHarness> {
  Future<void> setupWidget() async {
    await harness.tester
        .pumpWidget(harness.insertWidget(const WidgetUnderTest()));
  }
}

extension ExampleWhen on WidgetWhen<ExampleWidgetTestHarness> {
  Future<void> userPerformsSomeAction() async {
    await harness.tester.tap(find.text('1'));
    await harness.tester.pump();
  }
}

extension ExampleThen on WidgetThen<ExampleWidgetTestHarness> {
  Future<void> findsWidgetText() async {
    await harness.tester.pump();
    expect(find.text('2'), findsOneWidget);
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
          counter.count.value++;
        },
        child: ValueListenableBuilder(
          builder: (context, value, _) {
            return Column(
              children: [
                Text(value.toString()),
                const Text('Some really long text', key: Key('long_text')),
              ],
            );
          },
          valueListenable: counter.count,
        ),
      ),
    );
  }
}
