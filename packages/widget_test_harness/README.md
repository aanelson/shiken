# Test Harness
A package to help with the creation of test harnesses to allow better readability and composability of tests

Uses Given, When, then, but unlike a lot of other test frameworks there is a single callback.

based on the ebay given_when_then but improves the ability to use add mixins to have tests automatically configure themselves.

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

## Usage 

* [Writing tests](#writing-tests)
* [Writing harnesses](#writing-harnesses)
* [Writing Mixins](#writing-mixins)


### Without given_when_then

```dart
void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

### Minimal change with given_when_then
```dart
void main() {
  testWidgets('MyWidget has a title and message', harness((given, when, then) async {
    await given.pumpMyWidget(title: 'T', message: 'M');
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    then.findsOneWidget(titleFinder);
    then.findsOneWidget(messageFinder);
  }));
}
```

-- see [example_test.dart](test/src/example/example_test.dart) for example of usage
