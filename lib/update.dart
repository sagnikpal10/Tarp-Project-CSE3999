import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

class Update{
  void updateApp(){
    File file = new File("/home/sagnik/Desktop/game/res/wordgame");
    Map<dynamic, dynamic> data;
    http.get('https://flutter-project-62ee6.firebaseio.com/wordguessing.json').then((http.Response responce) {
      data = json.decode(responce.body);
      file.createSync();
      file.writeAsStringSync(json.encode(data));
      Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
      print(jsonFileContent["words"]);
    });
  }
  _read() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(directory.path + '/' + 'wordgamenewfile');
      Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
      print(jsonFileContent["words"]);
    } catch (e) {
      print("Couldn't read file");
    }
  }
}

void main() async{
  Update up = new Update();
  up._read();
}








