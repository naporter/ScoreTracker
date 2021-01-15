import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget{
  final Function addPlayer;

  NavigationBar({this.addPlayer});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 32,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blue,
          items: [
            BottomNavigationBarItem( //transparent icons to leave navigation bar but save them for future update
              icon: Icon(
                Icons.home_rounded,
                color: Colors.transparent,
              ),
              label: 'Upcoming feature: Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
                color: Colors.transparent,
              ),
              label: 'Upcoming feature: Saved Games',
            ),
          ],
        )
    );
  }

  void _changeScreen() {
    print('Changed Screen');
  }

}