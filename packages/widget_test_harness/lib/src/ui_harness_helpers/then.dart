import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

import '../given_when_then.dart';
import '../test_harness.dart';

extension CommonThenWidgetTestHelpers on Then<WidgetTestHarness> {
  void findsOneWidget(flutter_test.Finder finder) =>
      flutter_test.expect(finder, flutter_test.findsOneWidget);

  void findsNothing(flutter_test.Finder finder) =>
      flutter_test.expect(finder, flutter_test.findsNothing);

  void findsNWidgets(flutter_test.Finder finder, int n) =>
      flutter_test.expect(finder, flutter_test.findsNWidgets(n));

  void findsAtLeastNWidgets(flutter_test.Finder finder, int n) =>
      flutter_test.expect(finder, flutter_test.findsAtLeastNWidgets(n));

  void findsWidgetWithText(flutter_test.Finder finder, dynamic matcher) {
    final widget = finder.evaluate().first.widget;
    if (widget is Text) {
      flutter_test.expect(widget.data, matcher);
    } else if (widget is RichText) {
      flutter_test.expect(widget.text.toPlainText(), matcher);
    } else {
      throw UnimplementedError('could not match $widget to a text type');
    }
  }
}
