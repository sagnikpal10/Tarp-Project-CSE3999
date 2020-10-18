//import 'dart:math';
//import 'dart:convert';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
//import 'play.dart';
//
//class Game {
//  String secretWord;
//  List<String> displayWordList;
//  List<String> wrongLettersGuessed;
//  String displayWord;
////  Play p = new Play();
//  Map<dynamic, dynamic> jsonFileContent;
//  String desc;
//  String hint;
//  var bytes;
////  int idx;
//  Game(int idx) {
//    this.idx = idx;
//    displayWord = 'Guess the word!';
//    displayWordList = [];
//    generateRandomWord();
////    initDisplayWordList();
//    wrongLettersGuessed = [];
//  }
//
//  void generateRandomWord(int idx) async{
//
//    try {
//      final Directory directory = await getApplicationDocumentsDirectory();
//      final File file = File(directory.path + '/' + 'wordgamenewfile');
//      jsonFileContent = json.decode(file.readAsStringSync());
//      int n = Random.secure().nextInt(jsonFileContent["words"].length);
//      print(jsonFileContent);
//      int len = jsonFileContent["words"].length;
//      n = n%len;
//      do {
//      n = Random.secure().nextInt(jsonFileContent["words"].length);
//      } while (jsonFileContent["words"][n%len].length <= 3 || jsonFileContent["words"][n%len].length > 13);
//      n = idx%len;
//
//      secretWord = jsonFileContent["words"][n%len].toUpperCase();
////      print(secretWord);
////      print(jsonFileContent["data"][secretWord.toLowerCase()]);
//
//      desc = jsonFileContent["data"][secretWord.toLowerCase()]["meaning"];
//      hint = jsonFileContent["data"][secretWord.toLowerCase()]["hint"];
//      String image = jsonFileContent['data'][secretWord.toLowerCase()]['wordimage'];
//      image = image.substring(2,image.length - 1);
//      bytes = base64.decode(image);
//      print("Secret Word: "+secretWord);
//      print("Desc : "+ desc);
//      print("Hint : " + hint);
//      displayWordList = [];
//      for (int i = 0; i < secretWord.length; i++) displayWordList.add('_ ');
//      for (int i = 0; i < (secretWord.length / 3); i++) {
//        int n = Random.secure().nextInt(secretWord.length);
//        if (displayWordList[n] == "_ ")
//          replaceAll(secretWord[n%len]);
//        else
//          i++;
//      }
//      displayWord = displayWordList.join();
//    } catch (e) {
//      print("Couldn't read file");
//    }
//
//  }
//
////  void initDisplayWordList() {
////    displayWordList = [];
////    for (int i = 0; i < secretWord.length; i++) displayWordList.add('_ ');
////    for (int i = 0; i < (secretWord.length / 3); i++) {
////      int n = Random.secure().nextInt(secretWord.length);
////      if (displayWordList[n] == "_ ")
////        replaceAll(secretWord[n]);
////      else
////        i++;
////    }
////    displayWord = displayWordList.join();
////  }
//
//
////  void reSelect(){
////    int n = Random.secure().nextInt(jsonFileContent["words"].length);
////
////    int len = jsonFileContent["words"].length;
////    n = n%len;
////    do {
////      n = Random.secure().nextInt(jsonFileContent["words"].length);
////    } while (jsonFileContent["words"][n%len].length <= 5 || jsonFileContent["words"][n%len].length > 9);
////
////
////    secretWord = jsonFileContent["words"][n%len].toUpperCase();
////    print(secretWord);
////    print(secretWord.length);
////    displayWordList = [];
////    for (int i = 0; i < secretWord.length; i++) displayWordList.add('_ ');
////    for (int i = 0; i < (secretWord.length / 3); i++) {
////      int n = Random.secure().nextInt(secretWord.length);
////      if (displayWordList[n] == "_ ")
////        replaceAll(secretWord[n%len]);
////      else
////        i++;
////    }
////    displayWord = displayWordList.join();
////  }
//
//
//  void guessLetter(letter) {
//    int n = secretWord.indexOf(letter);
//    if (n >= 0) {
//      replaceAll(letter);
//      displayWord = displayWordList.join();
//    } else {
//      wrongLettersGuessed.add(letter);
//    }
//  }
//
//  void replaceAll(String letter) {
//    for (int i = 0; i < secretWord.length; i++) {
//      if (secretWord[i] == letter) {
//        displayWordList[i] = letter;
//      }
//    }
//  }
//
//  bool isWordGuessed() {
//    return displayWord.compareTo(secretWord) == 0;
//  }
//
//  bool hasLost() {
//    return wrongLettersGuessed.length >= 6;
//  }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
