import 'package:meta/meta.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/responses/payu_response.dart';
import 'package:psinder/services/mock/payments_service_mock.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

abstract class PaymentsService {
  factory PaymentsService.build() => isTesting
      ? PaymentsServiceMock(
          networkService: NetworkService.build(),
        )
      : PaymentsServiceImpl(
          networkService: NetworkService.build(),
        );

  Future<bool> hasPremium();
  Future<String> fetchPaymentUrl();
}

class PaymentsServiceImpl implements PaymentsService {
  PaymentsServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  @override
  Future<bool> hasPremium() async {
    // TODO: implement
    await Future.delayed(Duration(milliseconds: 500));

    return false;
  }

  @override
  Future<String> fetchPaymentUrl() async {
    final response = await _networkService.request(
      NetworkRequest(
        method: NetworkMethod.post,
        // TODO: endpoint: 'payments/pay'
        endpoint: 'https://psinder-payments.herokuapp.com/pay',
      ),
    );

    switch (response.statusCode) {
      case 200:
        final messageResponse = PayuResponse.fromXml(response.body);

        return messageResponse.redirectUri;

      default:
        throw PsinderException.unknown();
    }
  }
}
