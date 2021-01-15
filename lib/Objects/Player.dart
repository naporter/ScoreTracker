import 'dart:convert';

import 'package:flutter/material.dart';

class Player{
  String playerName;
  int playerScore = 0;
  MaterialColor playerColor = Colors.grey;

  Player({ this.playerName, this.playerScore , this.playerColor });

  // Map<String, dynamic> toMap(Player player) =>{
  //   'playerName': player.playerName,
  //   'playerScore': player.playerScore,
  //   'playerColor': player.playerColor,
  // };
  //
  // String encode(List<Player> players) => json.encode(
  //   players.map<Map<String, dynamic>>((player) => toMap(player)).toList(),
  // );
  //
  // List<Player> decode(String players) =>
  //     (json.decode(players) as List<dynamic>).map<Player>((player) => Player.fromJson(player)).toList();

}