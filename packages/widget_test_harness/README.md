# Test Harness
A package to help with the creation of test harnesses to allow better readability and composability of tests

Uses Given, When, then, but unlike a lot of other test frameworks there is a single callback.

based on the ebay given_when_then, but exposes setup in creation of hte harness which allows mixin or inheritance to reuse test setup/teardown code.

## Installation 💻

Add `test_harness` to your `pubspec.yaml`:

```yaml
dev_dependencies:
  widget_test_harness: 0.5.0
```

Install it:

```sh
flutter packages get
```

- [Test Harness](#test-harness)
  - [Installation 💻](#installation-)
  - [Harness setup](#harness-setup)
  - [Writing Mixins](#writing-mixins)
  - [Writing Tests](#writing-tests)


## Harness setup

Harnesses are setup by subclassing an appropriate harness class [`widgetTestHarness`] and [`unitTestHarness`].

[`widgetTestHarness`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/WidgetTestHarness-class.html
[`unitTestHarness`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/UnitTestHarness-class.html

Below is a basic example that has the included [`NetworkImageMixin`] which is used to mock the network image requests.

[`NetworkImageMixin`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/NetworkImageMixin-mixin.html

```dart
import 'package:widget_test_harness/widget_test_harness.dart';

class ExampleWidgetTestHarness extends WidgetTestHarness
    with NetworkImageMixin, CounterHarnessMixin {
  ExampleWidgetTestHarness(super.tester);

  @override
  List<int> bytesForUrlRequest(Uri url) {
    final file = File('test/test_resources/sunflower.jpg');
    final bytes = file.readAsBytesSync();
    return bytes;
  }
}
```

The harness is passed into [`Given`], [`When`], [`Then`] and extensions off of each can define methods.  

```dart
extension MyGivenForExample on Given<ExampleWidgetTestHarness> {
  Future<void> setupWidget() async {...}
}
extension MyWhenForExample on When<ExampleWidgetTestHarness> {
  Future<void> userPerformsSomeAction() {}
}
```

[`Given`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/Given-class.html
[`When`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/When-class.html
[`Then`]: https://pub.dev/documentation/widget_test_harness/latest/widget_test_harness/Then-class.html


## Writing Mixins

Using mixins different features can be reused throughout an application's test code.  

```dart
mixin CounterHarnessMixin on FlutterTestHarness {
  CounterModel counter = CounterModel();
  @override
  Widget setupWidgetTree(Widget child) {
    return super.setupWidgetTree(Provider.value(value: counter, child: child));
  }
}
extension CounterHarnessGiven on Given<CounterHarnessMixin> {
  void countIs(int value) {}
}
extension CounterHarnessThen on Then<CounterHarnessMixin> {
  void countEquals(int value) => expect(value,harness.counter.value);
}
```


## Writing Tests

Writing a test invokes a function that will create the harness and setup state for that individual test.  You should never have to use setup(), or teardown() while using a test harness.   

```dart
final uiHarness = HarnessSetup.setupWidgetHarness(ExampleWidgetTestHarness.new);

void main() {
   testWidgets('test Counter', uiHarness((given, when, then) async {
      given.countIs(1);
      await given.setupWidget();
      await when.userPerformsSomeAction();
      await then.findsWidgetText();
      then.countEquals(2);
    }));
}
```

-- see [example_test.dart](test/src/example/example_test.dart) for additional example of usage

