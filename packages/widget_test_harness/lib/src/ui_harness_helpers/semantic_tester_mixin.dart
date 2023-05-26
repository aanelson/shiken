import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_harness/widget_test_harness.dart';

/// Add to harness to support semantic testing
/// Handles the setup/teardown
///

base mixin SemanticTesterMixin on WidgetTestHarness {
  @override
  Future<void> setup() {
    _handle = tester.ensureSemantics();
    return super.setup();
  }

  late final SemanticsHandle _handle;
  @override
  void dispose() {
    _handle.dispose();
    super.dispose();
  }
}

extension SemanticsHandleTesterThen on Then<SemanticTesterMixin> {
  void matchesSemanticLabel(Finder find, String label) =>
      expect(tester.getSemantics(find), matchesSemantics(label: label));
}
