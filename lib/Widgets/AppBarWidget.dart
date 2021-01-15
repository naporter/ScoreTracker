import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Function deleteGame;

  AppBarWidget({this.deleteGame});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // centerTitle: true,
      elevation: 8,
      title: Text('Score Tracker'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          iconSize: 32.0,
          color: Colors.orange,
          tooltip: 'Save Game',
          alignment: AlignmentDirectional.center,
          splashRadius: 15.0,
          onPressed: deleteGame,
        ),
        // IconButton(
        //   icon: Icon(Icons.save),
        //   iconSize: 32.0,
        //   color: Colors.orange,
        //   tooltip: 'Save Game',
        //   alignment: AlignmentDirectional.center,
        //   splashRadius: 15.0,
        //   onPressed: deleteGame,
        // ),
      ],
    );
  }

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);
}
