import 'dart:async';
import 'dart:io';

/// Fake that [NetworkImageMixin] uses
class FakeHttpClient implements HttpClient {
  FakeHttpClient(this.image);

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
    final stream = Stream.value(image)
        .listen(onData, onDone: onDone, cancelOnError: cancelOnError);
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
