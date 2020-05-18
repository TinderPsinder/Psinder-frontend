import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/extensions/future_loader.dart';
import 'package:psinder/pages/register/register_page.dart';
import 'package:psinder/pages/splash/splash_page.dart';
import 'package:psinder/services/auth_service.dart';
import 'package:psinder/utils/show_alert.dart';
import 'package:psinder/widgets/psinder_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({@required AuthService authService, Key key})
      : assert(authService != null),
        _authService = authService,
        super(key: key);

  factory LoginPage.build() => LoginPage(authService: AuthService.build());

  final AuthService _authService;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('login.title')),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration:
                      InputDecoration(labelText: tr('login.username.title')),
                  validator: (value) =>
                      value.trim().isEmpty ? tr('login.username.error') : null,
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _passwordController,
                  decoration:
                      InputDecoration(labelText: tr('login.password.title')),
                  obscureText: true,
                  validator: (value) =>
                      value.trim().isEmpty ? tr('login.password.error') : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                    right: 32.0,
                    top: 32.0,
                    bottom: 64.0,
                  ),
                  child: PsinderButton(
                    text: tr('login.login'),
                    onPressed: _onLoginPressed,
                  ),
                ),
                Text(
                  tr('login.no_account'),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 36.0,
                    right: 36.0,
                    top: 16.0,
                  ),
                  child: PsinderButton(
                    text: tr('login.register'),
                    isFlat: true,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage.build(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    try {
      await Navigator.of(context).futureLoader(
        widget._authService.login(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SplashPage.build(),
        ),
      );
    } catch (exception) {
      await showAlert(
        context,
        content: exception.toString(),
        onOk: () => Navigator.pop(context),
      );
    }
  }
}
