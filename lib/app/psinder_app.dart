import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:psinder/pages/splash/splash_page.dart';

class PsinderApp extends StatelessWidget {
  const PsinderApp({Key key}) : super(key: key);

  factory PsinderApp.build() => PsinderApp();

  @override
  Widget build(BuildContext context) => EasyLocalization(
        child: Builder(
          builder: (context) => _buildApp(context),
        ),
        supportedLocales: [
          Locale('en'),
        ],
        path: 'assets/locale',
        useOnlyLangCode: true,
      );

  Widget _buildApp(BuildContext context) => MaterialApp(
        title: tr('app.title'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: SplashPage.build(),
      );
}
