import 'package:express_order/user/change_pass.dart';
import 'package:express_order/user/dashboard.dart';
import 'package:express_order/user/profile.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static List<Widget> _WidgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    ChangePass(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WidgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ' Dashboard ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ' Profile ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: ' Change Password ',
          )
        ],

      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,

      ),
    );
  }
}
