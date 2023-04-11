import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../given_when_then.dart';
import '../test_harness.dart';

extension CommonThenWidgetTestHelpers on WidgetThen<WidgetTestHarness> {
  void findsOneWidget(Finder finder) => expect(finder, findsOneWidget);

  void findsNothing(Finder finder) => expect(finder, findsNothing);

  void findsWidgetWithText(Finder finder, dynamic matcher) {
    final widget = finder.evaluate().first.widget;
    if (widget is Text) {
      expect(widget.data, matcher);
    } else if (widget is RichText) {
      expect(widget.text.toPlainText(), matcher);
    } else {
      throw UnimplementedError('could not match $widget to a text type');
    }
  }
}
