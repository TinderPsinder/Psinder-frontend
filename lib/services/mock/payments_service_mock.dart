import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';
import 'package:psinder/services/payments_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

class PaymentsServiceMock implements PaymentsService {
  PaymentsServiceMock({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  static var _hasPremium = false;

  @override
  Future<bool> hasPremium() async {
    await Future.delayed(Duration(milliseconds: 500));

    return _hasPremium;
  }

  @override
  Future<String> fetchPaymentUrl() async {
    final response = await _networkService.request(
      NetworkRequest(
        method: NetworkMethod.post,
        endpoint: 'https://secure.snd.payu.com/api/v2_1/orders',
        withToken: false,
        withBaseHeaders: false,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer d9a4536e-62ba-4f60-8017-6053211d3f47',
        },
        body: '''{
          "customerIp": "127.0.0.1",
          "merchantPosId": "300746",
          "description": "mock request",
          "currencyCode": "PLN",
          "totalAmount": "6900",
          "buyer": {
            "email": "jakubzimnyy@gmail.com",
            "phone": "500600700",
            "firstName": "Jakub",
            "lastName": "Zimny"
          },
          "settings": {
            "invoiceDisabled": true
          },
          "products": [
            {
              "name": "premium",
              "unitPrice": "6900",
              "quantity": "1"
            }
          ]
        }''',
      ),
    );

    switch (response.statusCode) {
      case 302:
        _hasPremium = true;

        return response.headers['location'];

      default:
        throw PsinderException.unknown();
    }
  }
}
