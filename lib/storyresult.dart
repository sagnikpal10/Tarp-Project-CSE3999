import 'package:flutter/material.dart';
import 'package:game/storylist.dart';
import 'storyGameLogic.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoryResult extends StatefulWidget {

  StoryGame story;
  StoryResult.fromData(this.story);
  @override
  _StoryResultState createState() => _StoryResultState(story);
}

class _StoryResultState extends State<StoryResult> {

  StoryGame story;
  bool _speaking = false;
  FlutterTts flutterTts = FlutterTts();
  _StoryResultState(this.story);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.storyTitle, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Moral of the Story', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
//            height: 500.0,
            child: Card(
              color: Colors.deepOrangeAccent.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
//                      width: 400,
//                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(child: Image(image: AssetImage('images/idea.png'), height: 200.0,)),
                          SizedBox(height: 10.0,),
                          Center(child: Text(story.storyData['moral'], style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0, ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('New Story', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: _Icons(),
        onPressed: () {
          _speaker();
        },
        heroTag: "mic",
      ),
    );
  }


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
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.speak(story.storyData['moral']);
  }

  void _stop() async {
    await flutterTts.stop();
  }
}
