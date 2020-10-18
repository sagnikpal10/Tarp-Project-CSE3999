import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'gameLogic.dart';
import 'result.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:vector_math/vector_math.dart' as math;

class Play extends StatefulWidget {

  GameWord game;
  int idx;
  Play.fromData(this.game, this.idx);

  @override
  _PlayState createState() => _PlayState(game, idx);
}

class _PlayState extends State<Play> {

  GameWord game;
  int idx;
  String lives;
  _PlayState(this.game, this.idx);
  @override
  void initState() {
    super.initState();
//    print(game.jsonFileContent);
    game.generateRandomWord(idx);
    lives = '6';
  }

  Widget _getImage(){
    if(game.bytes == null){
      return Image(
        image: AssetImage('images/source.gif'),
      );
    }
    else{
      return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.memory(game.bytes, fit: BoxFit.cover,),
      );
//      return new Image.memory(game.bytes, fit: BoxFit.cover,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Guess The Word", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            SizedBox(width: 95.0,),
            Text("Lives: " + lives, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FloatingActionButton(
          backgroundColor: Colors.white70.withOpacity(0.5),
          child: Icon(Icons.lightbulb_outline, size: 40.0,),
          onPressed: () {
            showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.6),
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                  return Transform(
                    transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        title: Image.asset('images/clue.gif'),
                        content: Text(game.hint, style: TextStyle(fontSize: 25.0),),
                      ),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 500),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {});
          },
          heroTag: "mic",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.white70.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 105.0, vertical: 10.0),
                child: Text(
                  'Change Word',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: (){
                  setState(() {
                    game.idx = game.idx + 1;
                    game.generateRandomWord(game.idx);
                  });
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 9.0, vertical: 17.0),
                height: 300.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                child: _getImage(),
              ),
              Text(
                game.displayWord,
                style: TextStyle(fontSize: 38),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _getKeyPad(),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _getKeyPad() {
    List<List<String>> letters = [
      ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
      ['H', 'I', 'J', 'K', 'L', 'M', 'N'],
      ['O', 'P', 'Q', 'R', 'S', 'T', 'U'],
      ['V', 'W', 'X', 'Y', 'Z'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:  MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: _getRow(0, letters),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: _getRow(1, letters),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: _getRow(2, letters),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56.0),
          child: _getRow(3, letters),
        ),

      ],
    );
  }

  Row _getRow(int rowIndex, List<List<String>> letters) {
    List<Widget> row = [];
    for (int i = 0; i < letters[rowIndex].length; i++) {
      row.add(_getLetterButton(letters[rowIndex][i]));
    }
    return Row(
      children: row,
    );
  }

  Widget _getLetterButton(String letter) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width / 9.0,
              height: 45,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: _getLetterColor(letter),
              ),
            ),
            onTap: () {
              if (game.displayWordList.contains(letter) ||
                  game.wrongLettersGuessed.contains(letter)) {

              } else {

                setState(() {
                  game.guessLetter(letter);
                });
                if (game.isWordGuessed() || game.hasLost()) {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Result.fromData(game, game.idx);
                  }));
                }
              }
              setState(() {
                lives = (6 - game.wrongLettersGuessed.length).toString();
              });
            },
          );
        },
      ),
    );
  }

  Color _getLetterColor(String letter) {
    if (game.displayWordList.contains(letter)) {
      return Colors.green;
    } else if (game.wrongLettersGuessed.contains(letter)) {
      return Colors.red;
    } else {
      return Colors.white70.withOpacity(0.5);
    }
  }
}

Future<void> _showMyDialog() async {
  return showDialog<void>(
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
