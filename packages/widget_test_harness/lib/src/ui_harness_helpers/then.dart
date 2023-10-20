import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

import '../given_when_then.dart';
import '../test_harness.dart';

extension CommonThenWidgetTestHelpers on Then<WidgetTestHarness> {
  void findsOneWidget(flutter_test.Finder finder, {String? reason}) =>
      flutter_test.expect(finder, flutter_test.findsOneWidget, reason: reason);

  void findsNothing(flutter_test.Finder finder, {String? reason}) =>
      flutter_test.expect(finder, flutter_test.findsNothing, reason: reason);

  void findsNWidgets(flutter_test.Finder finder, int n, {String? reason}) =>
      flutter_test.expect(finder, flutter_test.findsNWidgets(n), reason: reason);

  void findsAtLeastNWidgets(flutter_test.Finder finder, int n, {String? reason}) =>
      flutter_test.expect(finder, flutter_test.findsAtLeastNWidgets(n), reason: reason);

  void findsWidgetWithText(flutter_test.Finder finder, dynamic matcher, {String? reason}) {
    final widget = finder.evaluate().first.widget;
    if (widget is Text) {
      flutter_test.expect(widget.data, matcher, reason: reason);
    } else if (widget is RichText) {
      flutter_test.expect(widget.text.toPlainText(), matcher, reason: reason);
    } else if (widget is TextField) {
      flutter_test.expect(widget.controller!.text, matcher, reason: reason);
    } else {
      throw UnimplementedError('could not match $widget to a text type');
    }
  }
}
