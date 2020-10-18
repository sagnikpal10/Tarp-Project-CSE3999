import 'package:flutter/material.dart';
import 'dilaogueLogic.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DialogueWidget extends StatefulWidget {

  Dialogue conversation;
  DialogueWidget.fromData(this.conversation);
  @override
  _DialogueWidgetState createState() => _DialogueWidgetState(conversation);
}

class _DialogueWidgetState extends State<DialogueWidget> {

  Dialogue conversation;
  bool _speaking = false;
  FlutterTts flutterTts = FlutterTts();
  _DialogueWidgetState(this.conversation);

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
    await flutterTts.setPitch(0.5);
    await flutterTts.speak(conversation.presentScene['desc']);
  }

  void _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.title, style:  TextStyle(fontSize: 25.0),),
      ),
      floatingActionButton: FloatingActionButton(
        child: _Icons(),
        onPressed: () {
          _speaker();
        },
        heroTag: "mic",
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(12.0),
                height: 380.0,
                width: 400.0,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset('images/talking1.gif'),
                )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.all(15.0,),
//              height: 380.0,
              width: 600.0,
              decoration: BoxDecoration(
                  color: Colors.white12.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: Text(conversation.presentScene['desc'], style: TextStyle(fontSize: 20.0),),
            ),
            _getOptions(),
          ],
        ),
      ),
    );
  }

  Widget _getOptions(){
    if(conversation.presentScene['options'].length == 0){
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        onPressed: (){
          Navigator.of(context)
              .pop();
        },
        child: Text('Finish', style:  TextStyle(fontSize: 19.0),),
      );
    }
    else{
      return Expanded(
        child: new ListView.builder
          (
            itemCount: conversation.presentScene['options'].length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: new Text(conversation.presentScene['options'][Index]['option_text'], style:  TextStyle(fontSize: 18.0),),
                    onPressed: (){
                      setState(() {
                        _speaking = false;
                        _stop();
                        conversation.sceneIdx = conversation.presentScene['options'][Index]['next'] - 1;
                        conversation.loadScene();
                      });
                    }
                  );
            }
        ),
      );
    }
  }

}
