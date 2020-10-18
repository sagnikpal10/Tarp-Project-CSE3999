import 'package:flutter/material.dart';
import 'package:game/storyGameLogic.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'storyresult.dart';

class UnPage extends StatefulWidget {

  StoryGame story;
  UnPage.fromData(this.story);
  @override
  _UnPageState createState() => _UnPageState(story);
}

class _UnPageState extends State<UnPage> {

  StoryGame story;
  bool _speaking = false;
  FlutterTts flutterTts = FlutterTts();
  bool enabled = false;
  _UnPageState(this.story);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.storyTitle, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: _getWidget(),
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

  Widget _getWidget(){
    if(story.presentScene['interactive'] == 1){
      return _getIntWidget();
    }
    else{
      return _getUnIntWidget();
    }
  }

  Widget _getIntWidget(){
    return Container(
//        color: Colors.blue,
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
                child: Image.memory(story.bytes),
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
            child: Text(story.description, style: TextStyle(fontSize: 20.0),),
          ),
          Expanded(
            child: new ListView.builder
              (
                itemCount: story.options.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: new Text(story.options[Index]['desc'], style:  TextStyle(fontSize: 18.0),), onPressed: (){
                    _stop();
                    if(story.options[Index]['isCorrect'] == 1){
                      setState(() {
                        enabled = true;
                      });
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
                                  title: Image.asset('images/correct.png'),
                                  content: Text("Well Done that's correct!!", style: TextStyle(fontSize: 25.0),),
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    }
                    else{
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
                                  title: Image.asset('images/wrong.png'),
                                  content: Text("Sorry That's not the best way out!!", style: TextStyle(fontSize: 25.0),),
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    }
                  });
                }
            ),
          ),
          _getNextOption(),
        ],
      ),
    );
  }

  Widget _getNextOption(){
    if(enabled == true){
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Next Scene', style: TextStyle(fontSize: 20.0),),
            ),
        onPressed: (){
              setState(() {
                enabled = false;
              });
        print(story.sceneIdx);
        if(story.sceneIdx == story.storyData['scenes'].length - 1){
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
        return StoryResult.fromData(story);
        }));
        }
        else{
        setState(() {
        story.nextScene();
        story.LoadStory();
        _speaking = false;
        });
        }
  },
  );
    }
    else{
      return SizedBox();
    }
  }

  Widget _getUnIntWidget(){
    return Container(
//        color: Colors.blue,
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(12.0),
              height: 385.0,
              width: 400.0,
              decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.memory(story.bytes),
              )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.all(15.0,),
//              height: 380.0,
            width: 600.0,
            height: 240.0,
            decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Text(story.description, style: TextStyle(fontSize: 20.0),),
          ),
          SizedBox(height: 10.0,),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text('Next Scene', style: TextStyle(fontSize: 20.0),),
            onPressed: (){
              print(story.sceneIdx);
              if(story.sceneIdx == story.storyData['scenes'].length - 1){
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return StoryResult.fromData(story);
                }));
              }
              else{
                setState(() {
                  story.nextScene();
                  story.LoadStory();
                  _speaking = false;
                });
              }
            },
          )
        ],
      ),
    );
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
    await flutterTts.speak(story.description);
  }

  void _stop() async {
    await flutterTts.stop();
  }
}


