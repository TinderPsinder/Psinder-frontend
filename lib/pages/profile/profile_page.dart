import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/pages/edit_profile/edit_profile_page.dart';
import 'package:psinder/pages/payment/payment_page.dart';
import 'package:psinder/pages/splash/splash_page.dart';
import 'package:psinder/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({@required AuthService authService, Key key})
      : assert(authService != null),
        _authService = authService,
        super(key: key);

  factory ProfilePage.build() => ProfilePage(authService: AuthService.build());

  final AuthService _authService;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _buildPanel(
              icon: Icons.remove_red_eye,
              text: tr('profile.preview'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage.build(dog: Dog.mocks.first),
                ),
              ),
            ),
            _buildPanel(
              icon: Icons.monetization_on,
              text: tr('profile.premium'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage.build(),
                ),
              ),
            ),
            _buildPanel(
              icon: Icons.person,
              text: tr('profile.logout'),
              onTap: () async {
                await widget._authService.logout();
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SplashPage.build(),
                  ),
                );
              },
            ),
            _buildPanel(
              icon: Icons.bug_report,
              text: tr('profile.debug_mode'),
              trailing: Switch(
                value: isTesting,
                onChanged: (value) => setState(() => isTesting = value),
              ),
            ),
          ],
        ),
      );

  Widget _buildPanel({
    IconData icon,
    String text,
    void Function() onTap,
    Widget trailing,
  }) =>
      InkWell(
        child: Container(
          width: double.infinity,
          height: 52.0,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  icon,
                  size: 24.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
        onTap: onTap,
      );
}
