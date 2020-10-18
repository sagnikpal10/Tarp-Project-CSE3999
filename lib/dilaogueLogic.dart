import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class Dialogue {

  Map<dynamic, dynamic> jsonData;
  String title;
  Map<dynamic, dynamic> presentScene;
  int sceneIdx;
  Map<dynamic, dynamic> conv;


  Dialogue(){
    sceneIdx = 0;
    readData();
  }

  void readData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(directory.path + '/' + 'dialoguegamenewfile');
    jsonData = json.decode(file.readAsStringSync());
//    print(jsonData.toString());
  }

  void loadScene() {
    conv = jsonData['data'][title];
    presentScene = conv['scenes'][sceneIdx];
//    options = presentScene['options'];
  }


}