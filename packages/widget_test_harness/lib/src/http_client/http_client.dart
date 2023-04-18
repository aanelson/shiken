import 'dart:async';
import 'dart:io';

class FakeHttpClientForNetworkImage implements HttpClient {
  FakeHttpClientForNetworkImage(this.image);
  factory FakeHttpClientForNetworkImage.transparent() =>
      FakeHttpClientForNetworkImage((url) => _transparentImage);

  final List<int> Function(Uri url) image;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async =>
      FakeHttpClientRequest(FakeHttpClientResponse(image(url)));

  @override
  set autoUncompress(bool autoUncompress) {}
  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.toString());
  }
}

class FakeHttpClientRequest implements HttpClientRequest {
  FakeHttpClientRequest(this.response);

  final FakeHttpClientResponse response;

  @override
  HttpHeaders get headers => throw UnimplementedError();

  @override
  Future<HttpClientResponse> close() async {
    return response;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.toString());
  }
}

class FakeHttpClientResponse implements HttpClientResponse {
  FakeHttpClientResponse(this.image);
  final List<int> image;

  @override
  int get contentLength => image.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.toString());
  }

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    final stream = Stream.value(image).listen(onData);
    return stream;
  }

  @override
  int get statusCode => HttpStatus.ok;
}

class FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(invocation.toString());
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
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
