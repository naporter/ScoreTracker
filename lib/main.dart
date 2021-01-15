import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'Objects/Player.dart';
import 'Widgets/NavigationBar.dart';
import 'Widgets/AppBarWidget.dart';
import 'Widgets/PlayerWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Player> players = new List();
  final scrollController = ScrollController();

  void addPlayer() {
      players.add(Player(
          playerName: 'Player ${players.length}',
          playerScore: 0,
          playerColor: Colors.grey));
  }

  // Future<void> _saveData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   for(Player player in players){
  //   }
  //   // prefs.se'savedGame', _numPlayers);
  // }
  //
  // Future<void> _loadData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _numPlayers = prefs.getInt('_numPlayers') ?? 0;
  // }

  void deleteGame(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          players.clear();
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete Game"),
      content: Text("Are you sure you want to delete this game?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[700],
      bottomNavigationBar: NavigationBar(addPlayer: (){
        setState(() {
          players.add(Player(
              playerName: 'Player ${players.length}',
              playerScore: 0,
              playerColor: Colors.grey));
        });
      },),
      appBar: AppBarWidget(
        deleteGame: (){
          deleteGame(context);
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 32),
        controller: scrollController,
        key: UniqueKey(),
        itemCount: players.length,
        itemBuilder: (context, index) {
          return PlayerWidget(
              player: players[index],
              removePlayer: () {
                setState(() {
                  players.remove(players[index]);
                });
              });
        }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onPressed: (){
          setState(() {
            addPlayer();
          });
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        },
        backgroundColor: Colors.orange,
        tooltip: 'Add Player',
        child: Icon(
            Icons.add,
          size: 36,
        ),
      ),
    );
  }
}


// Future<void> _removeData() async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.remove('_numPlayers');
// }
//
// void _editPlayer() {
//   _removeData();
//   _numPlayers = 0;
//   print('Edit pressed');
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text('Choose a player to edit.'),
//     backgroundColor: Colors.blue,
//   ));
// }
