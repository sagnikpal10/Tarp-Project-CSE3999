import 'dart:convert';
import 'dart:io';
import 'package:game/update.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

class Update{

  Map<dynamic, dynamic> jsonData;


  _write(Map<dynamic, dynamic> text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File(directory.path + '/' + 'dialoguegamenewfile');
    print(directory.path + '/' + 'dialoguegamenewfile');
    await file.writeAsString(json.encode(text));
    print('Successfully Downloaded Data');
    _read();
  }

  _read() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(directory.path + '/' + 'dialoguegamenewfile');
      Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
      jsonData = jsonFileContent;
      print(jsonFileContent['titles']);
    } catch (e) {
      print("Couldn't read file");
    }
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Update up = new Update();
  Map<dynamic, dynamic> data;
  http.get('http://172.26.15.97:8000/convoapi').then((http.Response responce) {
    print('something');
    data = json.decode(responce.body);
    print(data.toString());
    up._write(data);
  });
}








