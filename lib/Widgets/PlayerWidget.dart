import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoretracker/Objects/Player.dart';


class PlayerWidget extends StatefulWidget {
  final Player player;
  final Function removePlayer;

  PlayerWidget({this.player, this.removePlayer});

  @override
  PlayerState createState() => PlayerState(player: player, removePlayer: removePlayer);
}

class PlayerState extends State<PlayerWidget> {
  Player player;
  Function removePlayer;
  Color pickerColor = Colors.grey;
  Color currentColor = Colors.grey;

  PlayerState({this.player, this.removePlayer});

  void incrementScore() {
    setState(() {
      player.playerScore++;
    });
  }

  void decrementScore() {
    setState(() {
      player.playerScore--;
    });
  }

  // void changeName() {
  //     showDialog<String>(
  //         context: context,
  //         builder: (context){
  //           String userMessage = 'Enter a Name';
  //           TextEditingController textController = TextEditingController();
  //           return StatefulBuilder(
  //             builder: (context, setState){
  //               return AlertDialog(
  //                 title: Text(userMessage),
  //                 content: Row(
  //                   children: [
  //                     Expanded(
  //                       child: TextField(
  //                         maxLength: 10,
  //                         autofocus: true,
  //                         controller: textController,
  //                         inputFormatters: [
  //                           LengthLimitingTextInputFormatter(10),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 actions: [
  //                   FlatButton(
  //                     child: Text(
  //                         'Cancel'
  //                     ),
  //                     onPressed: (){
  //                       textController.clear();
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   FlatButton(
  //                     child: Text(
  //                         'OK'
  //                     ),
  //                     onPressed: (){
  //                       if(textController.text.length > 10){
  //                         setState (() => userMessage = 'Name Too Long');
  //                       }
  //                       else{
  //                         player.playerName = textController.text;
  //                         textController.clear();
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                   )
  //                 ],
  //               );
  //             },
  //           );
  //         }
  //     );
  // }

  void editPlayer(){
    TextEditingController textController = TextEditingController();
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Edit Player'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Player Name',
                    ),
                  ),
                  BlockPicker(
                    pickerColor: currentColor,
                    onColorChanged: (color){
                      setState(() => pickerColor = color);
                    }
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  if(textController.text.isNotEmpty){
                    player.playerName = textController.text;
                    textController.clear();
                  }
                  setState(() => currentColor = pickerColor);
                  this.player.playerColor = pickerColor;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }

  Future<bool> dismiss(direction){
    if (direction == DismissDirection.startToEnd) {
      //delete player animation
      return Future<bool>.value(true);
    }
    //no animation
    editPlayer();
    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction){
        return dismiss(direction);
      },
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        decoration: BoxDecoration(
            color: player.playerColor,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              player.playerName,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            Text(
              player.playerScore.toString(),
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: player.playerColor.shade300,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: incrementScore,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: decrementScore,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      background: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          size: 40,
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.edit,
          size: 40,
        ),
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      ),
      onDismissed: (direction) {
        removePlayer();
      },
    );
  }
}
