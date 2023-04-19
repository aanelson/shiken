import 'dart:io';

import 'http_client.dart';
import '../test_harness.dart';

mixin NetworkImageMixin on FlutterTestHarness {
  @override
  Future<void> setupZones(Future<void> Function() child) {
    return HttpOverrides.runZoned(
      () => super.setupZones(child),
      createHttpClient: (_) => _httpClient,
    );
  }

  /// Used to provide a value for Http requests
  /// intended for [Image.network] and [NetworkImage]
  /// Can provide custom image by reading image from disk
  /// Example: 
  /// ```dart
  /// List<int> imageForUrl(Uri url) {
  ///   final file = File(path);
  ///   return file.readAsBytesSync();
  /// }
  /// ```
  List<int> bytesForUrlRequest(Uri url) => _transparentImage;

  late final HttpClient _httpClient = FakeHttpClient(bytesForUrlRequest);
}


const List<int> _transparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE
];
