import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/extensions/future_loader.dart';
import 'package:psinder/services/auth_service.dart';
import 'package:psinder/utils/show_alert.dart';
import 'package:psinder/widgets/checkbox_form_field.dart';
import 'package:psinder/widgets/psinder_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({@required AuthService authService, Key key})
      : assert(authService != null),
        _authService = authService,
        super(key: key);

  factory RegisterPage.build() =>
      RegisterPage(authService: AuthService.build());

  final AuthService _authService;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('register.title')),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: _buildFormContent(context),
            padding: EdgeInsets.all(32.0),
          ),
        ),
      );

  List<Widget> _buildFormContent(BuildContext context) => <Widget>[
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: tr('register.username.title')),
          validator: (value) =>
              value.trim().length < 3 ? tr('register.username.error') : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: tr('register.email.title')),
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              _validateEmail(value) ? tr('register.email.error') : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: tr('register.password.title')),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) =>
              value.trim().length < 6 ? tr('register.password.error') : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration:
              InputDecoration(labelText: tr('register.repeat_password.title')),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => _passwordController.text != value
              ? tr('register.repeat_password.error')
              : null,
        ),
        SizedBox(height: 24),
        CheckboxFormField(
          context: context,
          validator: (value) =>
              value ? null : tr('register.terms_and_conditions.error'),
          title: Text(
            tr('register.terms_and_conditions.title'),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        SizedBox(height: 24),
        Text(
          tr('register.password_hint'),
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 32.0,
          ),
          child: PsinderButton(
            text: tr('register.register'),
            onPressed: _onRegisterPressed,
          ),
        ),
      ];

  bool _validateEmail(String email) {
    final value = email?.trim() ?? '';
    if (value.length < 3) {
      return true;
    }

    final atIndex = value.indexOf('@');
    if (atIndex == -1 || atIndex == 0 || atIndex == value.length - 1) {
      return true;
    }

    return false;
  }

  Future<void> _onRegisterPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    try {
      final message = await Navigator.of(context).futureLoader(
        widget._authService.register(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );

      await showAlert(
        context,
        content: message,
        onOk: () => Navigator.pop(context),
      );
    } catch (exception) {
      await showAlert(context, content: exception.toString());
    }
  }
}
