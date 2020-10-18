import 'dart:convert';
import 'dart:io';
import 'package:game/update.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
//
class Update{

  Map<dynamic, dynamic> jsonData;
//  String s;
//  Update(){
//    _read();
//  }


  _write(Map<dynamic, dynamic> text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File(directory.path + '/' + 'imagetesting');
    print(directory.path + '/' + 'imagetesting');
//    file.createSync();
    await file.writeAsString(json.encode(text));

    print('Successfully Downloaded Data');
//    Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
//    print(jsonFileContent["words"]);
//    _read();
  }

  _read() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(directory.path + '/' + 'imagetesting');
      Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
      jsonData = jsonFileContent;
      print(jsonFileContent['title']);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  writeImage(bytes) async{
    final Directory directory = await getApplicationDocumentsDirectory();
    File file = new File(directory.path + '/' + 'imagetesting.png');
    print(directory.path + '/' + 'imagetesting.png');
    await file.writeAsBytesSync(bytes);
  }

}



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String img;
  Map<dynamic, dynamic> data;
  http.get('https://flutter-project-62ee6.firebaseio.com/wordguessing.json').then((http.Response responce) {
    data = json.decode(responce.body);
    img = data['data']['helllo']['wordimage'];
    print(img.substring(0,10));
//    LATIN1 = const latin1();
    var bytesInLatin1 = latin1.encode(img);
    var base64encoded = base64.encode(bytesInLatin1);
    var bytes = base64.decode(base64encoded);
    Update up = new Update();
    up.writeImage(bytes);
    print(bytes);
  });
}








