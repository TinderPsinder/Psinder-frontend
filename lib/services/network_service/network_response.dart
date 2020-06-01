import 'package:meta/meta.dart';

class NetworkResponse {
  NetworkResponse({@required this.statusCode, this.body})
      : assert(statusCode != null);

  final int statusCode;
  final String body;

  @override
  String toString() =>
      'NetworkResponse(statusCode: $statusCode, body: "$body")';
}
