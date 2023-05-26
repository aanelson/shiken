import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

base mixin LoginHarnessMixin on FlutterTestHarness {
  final ValueNotifier<bool> loggedIn = ValueNotifier(false);
  @override
  Widget setupWidgetTree(Widget child) {
    return super.setupWidgetTree(Provider.value(value: loggedIn, child: child));
  }
}

extension LoginMixin on Given<LoginHarnessMixin> {
  void isLoggedIn() => harness.loggedIn.value = true;
}
