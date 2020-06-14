import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';

class NetworkRequest {
  NetworkRequest({
    @required this.method,
    @required this.endpoint,
    this.withToken = true,
    this.withBaseHeaders = true,
    this.headers = const {},
    this.body,
  })  : assert(method != null),
        assert(endpoint != null),
        assert(withToken != null),
        assert(withBaseHeaders != null),
        assert(headers != null);

  final NetworkMethod method;
  final String endpoint;
  final bool withToken;
  final bool withBaseHeaders;
  final Map<String, String> headers;
  final dynamic body;

  bool get isEndpointAbsolute =>
      endpoint.startsWith('http://') || endpoint.startsWith('https://');

  @override
  String toString() =>
      'NetworkRequest(method: $method, endpoint: "$endpoint", withToken: $withToken, withBaseHeaders: $withBaseHeaders, headers: $headers, body: "$body")';
}
