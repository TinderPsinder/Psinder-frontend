import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/services/payments_service.dart';
import 'package:psinder/utils/show_alert.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({@required PaymentsService paymentsService, Key key})
      : assert(paymentsService != null),
        _paymentsService = paymentsService,
        super(key: key);

  factory PaymentPage.build() => PaymentPage(
        paymentsService: PaymentsService.build(),
      );

  final PaymentsService _paymentsService;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = false;
  String _paymentUrl;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _startPayment());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('payment.title')),
        ),
        body: Stack(
          children: <Widget>[
            if (_paymentUrl != null)
              WebView(
                initialUrl: _paymentUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (page) {
                  if (page.endsWith('/auth')) {
                    showAlert(
                      context,
                      content: tr('payment.success'),
                      onOk: () => Navigator.pop(context),
                    );
                  }
                },
                onPageFinished: (page) {
                  if (_isLoading) {
                    setState(() => _isLoading = false);
                  }
                },
              ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      );

  Future<void> _startPayment() async {
    setState(() => _isLoading = true);

    try {
      final paymentUrl = await widget._paymentsService.fetchPaymentUrl();
      setState(() => _paymentUrl = paymentUrl);
    } catch (exception) {
      await showAlert(
        context,
        content: exception.toString(),
        onOk: () => Navigator.pop(context),
      );
    }
  }
}
