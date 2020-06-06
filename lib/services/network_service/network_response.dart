import 'package:meta/meta.dart';

class NetworkResponse {
  NetworkResponse({@required this.statusCode, this.headers, this.body})
      : assert(statusCode != null);

  final int statusCode;
  final Map<String, String> headers;
  final String body;

  @override
  String toString() =>
      'NetworkResponse(statusCode: $statusCode, headers: $headers, body: "$body")';
}
