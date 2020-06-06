import 'package:meta/meta.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/requests/login_request.dart';
import 'package:psinder/models/requests/signup_request.dart';
import 'package:psinder/models/responses/jwt_response.dart';
import 'package:psinder/models/responses/message_response.dart';
import 'package:psinder/models/role.dart';
import 'package:psinder/services/mock/auth_service_mock.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';
import 'package:psinder/services/persistence_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

abstract class AuthService {
  factory AuthService.build() => isTesting
      ? AuthServiceMock()
      : AuthServiceImpl(
          networkService: NetworkService.build(),
          persistenceService: PersistenceService.build(),
        );

  Future<bool> isLoggedIn();

  Future<void> login({
    @required String username,
    @required String password,
  });

  Future<String> register({
    @required String username,
    @required String email,
    @required String password,
  });

  Future<void> logout();
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    @required NetworkService networkService,
    @required PersistenceService persistenceService,
  })  : assert(networkService != null),
        assert(persistenceService != null),
        _networkService = networkService,
        _persistenceService = persistenceService;

  final NetworkService _networkService;
  final PersistenceService _persistenceService;

  @override
  Future<bool> isLoggedIn() async {
    return await _persistenceService.getToken() != null;
  }

  @override
  Future<void> login({
    String username,
    String password,
  }) async {
    final request = LoginRequest(
      username: username,
      password: password,
    );

    final response = await _networkService.request(
      NetworkRequest(
        method: NetworkMethod.post,
        endpoint: 'auth/signin',
        withToken: false,
        body: request.toXml(),
      ),
    );

    switch (response.statusCode) {
      case 200:
        final jwtResponse = JwtResponse.fromXml(response.body);
        if (jwtResponse.tokenType != 'Bearer') {
          throw PsinderException('exception.auth.non_bearer');
        }

        await _persistenceService.setToken(jwtResponse.accessToken);
        break;

      case 401:
        throw PsinderException('exception.auth.unauthorized');

      default:
        throw PsinderException.unknown();
    }
  }

  @override
  Future<String> register({
    String username,
    String email,
    String password,
  }) async {
    final request = SignupRequest(
      username: username,
      email: email,
      password: password,
      roles: {
        Role.admin,
        Role.moderator,
        Role.user,
      },
    );

    final response = await _networkService.request(
      NetworkRequest(
        method: NetworkMethod.post,
        endpoint: 'auth/signup',
        withToken: false,
        body: request.toXml(),
      ),
    );

    switch (response.statusCode) {
      case 200:
        final messageResponse = MessageResponse.fromXml(response.body);

        return messageResponse.message;

      default:
        throw PsinderException.unknown();
    }
  }

  @override
  Future<void> logout() async {
    await _persistenceService.setToken(null);
  }
}
