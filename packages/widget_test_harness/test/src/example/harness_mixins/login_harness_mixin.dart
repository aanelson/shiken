import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

mixin LoginHarnessMixin on TestHarness {
  final ValueNotifier<bool> loggedIn = ValueNotifier(false);
  @override
  Widget insertWidget(Widget child) {
    return super.insertWidget(Provider.value(value: loggedIn, child: child));
  }
}

extension LoginMixin on Given<LoginHarnessMixin> {
  void isLoggedIn() => harness.loggedIn.value = true;
}
