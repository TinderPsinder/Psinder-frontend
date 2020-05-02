import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';

class NetworkRequest {
  NetworkRequest({
    @required this.method,
    @required this.endpoint,
    this.withToken = true,
    this.headers = const {},
    this.body,
  })  : assert(method != null),
        assert(endpoint != null),
        assert(withToken != null),
        assert(headers != null);

  final NetworkMethod method;
  final String endpoint;
  final bool withToken;
  final Map<String, String> headers;
  final dynamic body;

  String toString() =>
      'NetworkRequest(method: $method, endpoint: "$endpoint", withToken: $withToken, headers: $headers, body: "$body")';
}
