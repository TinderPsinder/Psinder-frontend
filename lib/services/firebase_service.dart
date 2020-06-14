import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_response.dart';
import 'package:psinder/services/network_service/network_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

abstract class FirebaseService {
  factory FirebaseService.build() => FirebaseServiceImpl(
        networkService: NetworkService.build(),
      );

  Future<String> uploadToStorage({
    String bucket,
    String contentType,
    @required dynamic content,
    @required String path,
  });
}

class FirebaseServiceImpl implements FirebaseService {
  FirebaseServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  static const firebaseUrl = 'https://firebasestorage.googleapis.com/v0/b';
  static const defaultBucket = 'psinder-cf8de.appspot.com';

  final NetworkService _networkService;

  @override
  Future<String> uploadToStorage({
    String bucket,
    String contentType,
    @required dynamic content,
    @required String path,
  }) async {
    final targetBucket = bucket ?? defaultBucket;
    final targetPath = Uri.encodeQueryComponent(path);

    final response = await _networkService.request(
      NetworkRequest(
        method: NetworkMethod.post,
        endpoint:
            '$firebaseUrl/$targetBucket/o?uploadType=media&name=$targetPath',
        withToken: false,
        withBaseHeaders: false,
        headers: {
          if (contentType != null) 'Content-Type': contentType,
        },
        body: content,
      ),
    );

    switch (response.statusCode) {
      case 200:
        return _downloadUrlFromResponse(response);

      default:
        throw PsinderException.unknown();
    }
  }

  String _downloadUrlFromResponse(NetworkResponse response) {
    final Map<String, dynamic> body = jsonDecode(response.body);

    final name = body['name'] as String;
    if (name == null) throw PsinderException.parse('name');

    final bucket = body['bucket'] as String;
    if (bucket == null) throw PsinderException.parse('bucket');

    final token = body['downloadTokens'] as String;
    if (token == null) throw PsinderException.parse('downloadTokens');

    final targetName = Uri.encodeQueryComponent(name);

    return '$firebaseUrl/$bucket/o/$targetName?alt=media&token=$token';
  }
}
