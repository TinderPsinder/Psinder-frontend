import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/pages/login/login_page.dart';
import 'package:psinder/pages/main/main_page.dart';
import 'package:psinder/services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({@required AuthService authService, Key key})
      : assert(authService != null),
        _authService = authService,
        super(key: key);

  factory SplashPage.build() => SplashPage(authService: AuthService.build());

  final AuthService _authService;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAuthorization());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('app.title')),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Future<void> _checkAuthorization() async {
    final isLoggedIn = await widget._authService.isLoggedIn();

    await Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            isLoggedIn ? MainPage.build() : LoginPage.build(),
      ),
    );
  }
}
