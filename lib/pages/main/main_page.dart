import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/pages/cards/cards_page.dart';
import 'package:psinder/pages/splash/splash_page.dart';
import 'package:psinder/services/auth_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  factory MainPage.build() => MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<_MainPageTab> _tabs;

  int _selectedTabIndex;

  @override
  void initState() {
    super.initState();

    _tabs = [
      _MainPageTab(
        title: tr('main.cards'),
        icon: Icons.credit_card,
        builder: () => CardsPage.build(),
      ),
      _MainPageTab(
        title: '-',
        icon: Icons.place,
        builder: () => Container(),
      ),
      _MainPageTab(
        title: '-',
        icon: Icons.settings,
        builder: () => Container(
          alignment: Alignment.center,
          child: MaterialButton(
            child: Text('Wyloguj'),
            onPressed: () async {
              // TODO: Temporary button to logout
              await AuthService.build().logout();
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SplashPage.build(),
                ),
              );
            },
          ),
        ),
      ),
    ];

    _selectedTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('main.title')),
        ),
        body: _tabs[_selectedTabIndex].widget,
        bottomNavigationBar: BottomNavigationBar(
          items: _tabs
              .map(
                (tab) => BottomNavigationBarItem(
                  title: Text(tab.title),
                  icon: Icon(tab.icon),
                ),
              )
              .toList(),
          currentIndex: _selectedTabIndex,
          onTap: _onTabTapped,
        ),
      );

  void _onTabTapped(int index) => setState(() {
        _selectedTabIndex = index;
      });
}

class _MainPageTab {
  final String title;
  final IconData icon;
  final Widget Function() builder;

  _MainPageTab({
    @required this.title,
    @required this.icon,
    @required this.builder,
  })  : assert(title != null),
        assert(icon != null),
        assert(builder != null);

  Widget get widget => _widget ??= builder();

  Widget _widget;
}
