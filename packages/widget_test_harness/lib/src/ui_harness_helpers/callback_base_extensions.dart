import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/src/given_when_then.dart';

import '../test_harness.dart';

extension CallbackClassBaseWidgetTester
    on GWTBase<WidgetTestHarness> {
  @protected
  WidgetTester get tester => harness.tester;
}
