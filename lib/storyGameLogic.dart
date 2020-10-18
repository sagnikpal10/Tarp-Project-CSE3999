import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'play.dart';
import 'dart:convert';
import 'dart:io';
import 'package:game/update.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

class StoryGame {

  Map<dynamic, dynamic> jsonData;
  Map<dynamic, dynamic> storyData;
  Map<dynamic, dynamic> presentScene;
  String storyTitle;
  int sceneIdx;
  var bytes;
  String description;
  List<dynamic> options = [];

  StoryGame(){
    sceneIdx = 0;
    readData();
  }

    void readData() async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(directory.path + '/' + 'storygamenewfile');
      jsonData = json.decode(file.readAsStringSync());
    }

    void readStory(){
      storyData = jsonData['data'][storyTitle];
      presentScene = storyData['scenes'][sceneIdx];
    }

    void nextScene(){
      sceneIdx = sceneIdx + 1;
      presentScene = storyData['scenes'][sceneIdx];
    }

    void LoadStory(){
      presentScene = storyData['scenes'][sceneIdx];
      String image = presentScene['image'];
      image = image.substring(2,image.length - 1);
      bytes = base64.decode(image);
      description = presentScene['text'];
      options = presentScene['options'];
    }
}
