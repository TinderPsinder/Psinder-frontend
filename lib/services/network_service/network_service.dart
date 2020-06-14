import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_response.dart';
import 'package:psinder/services/persistence_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

abstract class NetworkService {
  factory NetworkService.build() => NetworkServiceImpl(
        persistenceService: PersistenceService.build(),
      );

  Future<NetworkResponse> request(NetworkRequest request);
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl({@required PersistenceService persistenceService})
      : assert(persistenceService != null),
        _persistenceService = persistenceService;

  // static const baseUrl = 'http://localhost/api/';
  static const baseUrl = 'https://psinder-gateway.herokuapp.com/api/';

  static const baseHeaders = {
    'Content-Type': 'application/xml',
    'Accept': 'application/xml',
  };

  final PersistenceService _persistenceService;

  @override
  Future<NetworkResponse> request(NetworkRequest request) async {
    final token = await _persistenceService.getToken();
    final requestUrl = request.isEndpointAbsolute
        ? request.endpoint
        : baseUrl + request.endpoint;
    final requestHeaders = {
      if (request.withBaseHeaders) ...baseHeaders,
      ...request.headers,
      if (request.withToken && token != null) ...{
        'Authorization': 'Bearer $token',
      },
    };

    http.Response response;

    try {
      switch (request.method) {
        case NetworkMethod.get:
          response = await http.get(
            requestUrl,
            headers: requestHeaders,
          );
          break;

        case NetworkMethod.post:
          response = await http.post(
            requestUrl,
            headers: requestHeaders,
            body: request.body,
          );
          break;
      }

      if (request.withToken && response.statusCode == 401) {
        await _persistenceService.setToken(null);
      }

      final result = NetworkResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: response.body,
      );

      print(request);
      print(result);

      return result;
    } on SocketException catch (exception) {
      throw PsinderException.network(exception);
    } catch (exception) {
      throw PsinderException.unknown();
    }
  }
}
