import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'play.dart';

class GameWord {

  // Word Game Related Attributes
  String secretWord;
  List<String> displayWordList;
  List<String> wrongLettersGuessed;
  int idx;
  String displayWord;
  Map<dynamic, dynamic> jsonFileContent;
  String desc;
  String hint;
  var bytes;

  GameWord() {

    // Initializing the variables
    displayWord = 'Guess the word!';
    displayWordList = [];
    wrongLettersGuessed = [];
    readData();
  }

  void readData() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(directory.path + '/' + 'wordgamenewfile');
    jsonFileContent = json.decode(file.readAsStringSync());
    idx = Random.secure().nextInt(jsonFileContent["words"].length);
  }

  void generateRandomWord(int index) async{
    displayWord = 'Guess the word!';
    displayWordList = [];
    wrongLettersGuessed = [];
    try {

      print(index);
      int len = jsonFileContent['words'].length;
      print(len);
      secretWord = jsonFileContent["words"][index%len].toUpperCase();
      desc = jsonFileContent["data"][secretWord.toLowerCase()]["meaning"];
      hint = jsonFileContent["data"][secretWord.toLowerCase()]["hint"];
      String image = jsonFileContent['data'][secretWord.toLowerCase()]['wordimage'];
      image = image.substring(2,image.length - 1);
      bytes = base64.decode(image);
      print("Secret Word: " + secretWord);
      print("Desc: " + desc);
      print("Hint: " + hint);

      displayWordList = [];
      for (int i = 0; i < secretWord.length; i++) displayWordList.add('_ ');
      for (int i = 0; i < (secretWord.length / 3); i++) {
        int n = Random.secure().nextInt(secretWord.length);
        if (displayWordList[n] == "_ ")
          replaceAll(secretWord[n%len]);
        else
          i++;
      }
      displayWord = displayWordList.join();
    } catch (e) {
      print("Couldn't read file");
    }

  }


  void guessLetter(letter) {
    int n = secretWord.indexOf(letter);
    if (n >= 0) {
      replaceAll(letter);
      displayWord = displayWordList.join();
    } else {
      wrongLettersGuessed.add(letter);
    }
  }

  void replaceAll(String letter) {
    for (int i = 0; i < secretWord.length; i++) {
      if (secretWord[i] == letter) {
        displayWordList[i] = letter;
      }
    }
  }

  bool isWordGuessed() {
    return displayWord.compareTo(secretWord) == 0;
  }

  bool hasLost() {
    return wrongLettersGuessed.length >= 6;
  }
}



















