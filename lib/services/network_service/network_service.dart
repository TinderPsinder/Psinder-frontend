import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_response.dart';
import 'package:psinder/services/persistence_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

abstract class NetworkService {
  factory NetworkService.build() => NetworkServiceImpl(
        persistenceService: PersistenceService.build(),
      );

  Future<NetworkResponse> request({
    @required NetworkMethod method,
    @required String endpoint,
    bool withToken = true,
    Map<String, String> headers,
    dynamic body,
  });
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl({@required PersistenceService persistenceService})
      : assert(persistenceService != null),
        _persistenceService = persistenceService;

  static const baseUrl = 'http://localhost/api/';

  static const baseHeaders = {
    'Content-Type': 'application/xml',
    'Accept': 'application/xml',
  };

  final PersistenceService _persistenceService;

  Future<NetworkResponse> request({
    @required NetworkMethod method,
    @required String endpoint,
    bool withToken = true,
    Map<String, String> headers = const {},
    dynamic body,
  }) async {
    final token = await _persistenceService.getToken();
    final requestUrl = baseUrl + endpoint;
    final requestHeaders = {
      ...baseHeaders,
      ...headers,
      if (withToken && token != null) ...{
        'Authorization': 'Bearer $token',
      },
    };

    http.Response response;

    try {
      switch (method) {
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
            body: body,
          );
          break;
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        body: response.body,
      );
    } on SocketException catch (exception) {
      throw PsinderException.network(exception);
    } catch (exception) {
      throw PsinderException.unknown();
    }
  }
}
