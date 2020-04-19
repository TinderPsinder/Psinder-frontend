import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:psinder/pages/cards/cards_page.dart';

class MainPage extends StatefulWidget {
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
        builder: () => CardsPage(),
      ),
      _MainPageTab(
        title: '-',
        icon: Icons.place,
        builder: () => Container(),
      ),
      _MainPageTab(
        title: '-',
        icon: Icons.settings,
        builder: () => Container(),
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
