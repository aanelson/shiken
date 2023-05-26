# Design doc

- The purpose of this document is to record the reasons for the design decisions of this api

# Design goals

1. Make setting up a new harness as easy as possible.  Testing setup tends to get more and more complicated as a project gets bigger.  Which generally leads to either mocking everything and testing only individual classes or only doing full app testing.  
2. Don't use code generation.  
3. Allow escape hatches.  
4. Avoid dependencies.
5. As part of making setup easy. Make reuse of common functionality easy and consistent.  

## Usage of mixins vs compositing classes

The usage of mixins has the unfortunate side effect of requiring the consumer to always call super correctly.  The alternative would be to have an array of setup classes.  For example,

```dart
class CounterSetup extends HarnessSetup {
    //do stuff
}

class Harness extends WidgetTestHarness {
    @override
    final setupList = [CounterSetup(),NetworkImageSetup()];
}
```

The problem is there is no easy way to provide the appropriate methods on given,when and then.

## HarnessSetup 

HarnessSetup is there because dart does not have a way to declare a factory constructor in an abstract class.  Maybe this can be updated once macro support is finished, but it would be great to write something like below and not have to deal with having HarnessSetup create a class.

```dart
widgetTest('something', Harness.run((given,when,then) async {}));
or
widgetTest('something2', harness<Harness>((given,when,then) async {}));
```

## Base modifier

Base modifier is there because the order dart checks conformance is strictly left to right.  It always goes extends, with, implements, thus meaning that extends will always be first and the mixins must use on instead of implements.

## Using inheritance/mixins instead of composition

The use of inheritance instead composition was deliberate.  It allows mixins to define shared given/when/then methods that will be exposed to tests when the corresponding mixin is added to a harness. 