import 'package:flutter/material.dart';
import 'play.dart';
import 'gameLogic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class Result extends StatefulWidget {
  final GameWord game;
  final int idx;
  Result.fromData(
      this.game, this.idx
      );

  @override
  _ResultState createState() => _ResultState(game);
}

class _ResultState extends State<Result> {


  GameWord game;
  _ResultState(this.game);
  bool _speaking = false;
  FlutterTts flutterTts = FlutterTts();
  Widget _speaker(){
    if(_speaking == true){
      _stop();
      setState(() {
        _speaking = false;
      });
    }
    else{
      _speak();
      setState(() {
        _speaking = true;
      });
    }
  }

  Widget _Icons() {
    if(_speaking == true){
      return Icon(Icons.mic);
    }
    else{
      return Icon(Icons.mic_off);
    }
  }

  void _speak() async {
    await flutterTts.setSpeechRate(0.85);
    await flutterTts.speak(widget.game.desc);
  }

  void _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        child: _Icons(),
        onPressed: () {
          _speaker();
        },
        heroTag: "mic",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 40.0,),
            Text(
              "Word: " + widget.game.secretWord,
              style: TextStyle(fontSize: 30),
            ),
            Card(
              margin: EdgeInsets.all(25.0),
              color: Colors.deepOrangeAccent.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: Container(
                  height: 450.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: _getResult(),
                    )
                ),
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Next Word",
                  style: TextStyle(fontSize: 25,),
                ),
              ),
              color: Colors.blueGrey,
              onPressed: () {
                widget.game.idx = widget.game.idx+1;
                widget.game.generateRandomWord(widget.idx);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Play.fromData(widget.game, widget.game.idx);
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getResult() {
    if (widget.game.isWordGuessed()) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              'images/unnamed.png',
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              widget.game.desc,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'images/unnamed.png',
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.game.desc,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      );
    }
  }
}

