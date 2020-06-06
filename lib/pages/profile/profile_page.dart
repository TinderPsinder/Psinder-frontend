import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/pages/dog/dog_page.dart';
import 'package:psinder/pages/edit_profile/edit_profile_page.dart';
import 'package:psinder/pages/payment/payment_page.dart';
import 'package:psinder/pages/splash/splash_page.dart';
import 'package:psinder/services/auth_service.dart';
import 'package:psinder/services/payments_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    @required AuthService authService,
    @required PaymentsService paymentsService,
    Key key,
  })  : assert(authService != null),
        assert(paymentsService != null),
        _authService = authService,
        _paymentsService = paymentsService,
        super(key: key);

  factory ProfilePage.build() => ProfilePage(
        authService: AuthService.build(),
        paymentsService: PaymentsService.build(),
      );

  final AuthService _authService;
  final PaymentsService _paymentsService;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _dog = Dog.mocks[2];
  var _hasPremium = false;

  @override
  void initState() {
    super.initState();

    _refreshPremium();
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          _hasPremium
              ? Banner(
                  location: BannerLocation.topStart,
                  message: tr('profile.premium'),
                  color: Colors.pink.shade900,
                  child: _buildProfileInfo(),
                )
              : _buildProfileInfo(),
          _buildPanel(
            icon: Icons.edit,
            text: tr('profile.edit_profile'),
            onTap: () async {
              final newDog = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage.build(dog: _dog),
                ),
              );

              if (newDog != null) {
                setState(() => _dog = newDog);
              }
            },
            isFirst: true,
          ),
          _buildPanel(
            icon: Icons.monetization_on,
            text: tr('profile.buy_premium'),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage.build(),
                ),
              );

              await _refreshPremium();
            },
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
          SizedBox(height: 32.0),
          _buildPanel(
            icon: Icons.perm_device_information,
            text: tr('profile.about_the_app'),
            onTap: () => showAboutDialog(context: context),
            isFirst: true,
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
      );

  Widget _buildProfileInfo() => InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(_dog.pictures.first),
                radius: 64.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildNameAge(),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DogPage.build(dog: _dog),
          ),
        ),
      );

  Widget _buildNameAge() => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _dog.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            ', ${_dog.age}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );

  Widget _buildPanel({
    IconData icon,
    String text,
    void Function() onTap,
    Widget trailing,
    bool isFirst = false,
  }) =>
      Material(
        color: Colors.grey.shade100,
        child: InkWell(
          child: Container(
            width: double.infinity,
            height: 52.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(
                top: isFirst
                    ? BorderSide(color: Colors.grey.shade200)
                    : BorderSide.none,
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
        ),
      );

  Future<void> _refreshPremium() async {
    final hasPremium = await widget._paymentsService.hasPremium();
    setState(() => _hasPremium = hasPremium);
  }
}
