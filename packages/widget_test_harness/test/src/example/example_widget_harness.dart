import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

import 'counter_harness_mixin.dart';
import 'example_model.dart';

final uiHarness = HarnessSetup.setupWidgetHarness(ExampleWidgetTestHarness.new);

class ExampleWidgetTestHarness extends WidgetTestHarness
    with CounterHarnessMixin {
  ExampleWidgetTestHarness(super.tester);

  @override
  List<int> bytesForUrlRequest(Uri url) {
    final file = File('test/test_resources/sunflower.jpg');
    final bytes = file.readAsBytesSync();
    return bytes;
  }
}

extension ExampleGiven on Given<ExampleWidgetTestHarness> {
  Future<void> setupWidget() async {
    await tester.pumpWidget(harness.insertWidget(const WidgetUnderTest()));
  }
}

extension ExampleWhen on When<ExampleWidgetTestHarness> {
  Future<void> userPerformsSomeAction() async {
    await harness.tester.tap(find.text('1'));
    await harness.tester.pump();
  }
}

extension ExampleThen on Then<ExampleWidgetTestHarness> {
  Future<void> findsWidgetText() async {
    await harness.tester.pump();
    expect(find.text('2'), findsOneWidget);
  }

  Future<void> matchesGolden(String filename) async {
    await screenMatchesGolden(harness.tester, filename,
        customPump: (tester) => tester.pump());
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
                Image.network(
                  'https://randomuser.me/api/portraits/thumb/men/75.jpg',
                  height: 200,
                ),
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
