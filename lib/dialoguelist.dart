import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'storyGameLogic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'InteractiveStoryWidget.dart';
import 'dilaogueLogic.dart';
import 'dialogue.dart';

class DList extends StatefulWidget {

  Dialogue conversation;
  DList.fromData(this.conversation);

  @override
  _DListState createState() => _DListState(conversation);
}

class _DListState extends State<DList> {


  Dialogue conversation;
  _DListState(this.conversation);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation List', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.black12,
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black12.withOpacity(0.25), BlendMode.dstATop),
            image: AssetImage('images/bookshelf.jpg'),
          ),
        ),
//        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new ListView.builder
                (
                  itemCount: conversation.jsonData['titles'].length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return Card(
                      color: Colors.deepOrangeAccent.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          conversation.title = conversation.jsonData['titles'][Index];
                          print(Index);
                          print(conversation.title);
                          conversation.sceneIdx = 0;
//                          story.readStory();
                          conversation.loadScene();
//                          print(story.sceneIdx);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DialogueWidget.fromData(conversation);
                          }));
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 320,
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(conversation.jsonData['titles'][Index], style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Splll extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splll> {

  @override
  void initState() {
    Dialogue conversation = new Dialogue();
    Timer(Duration(milliseconds: 2100 ), (){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return DList.fromData(conversation);
      }));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.blueGrey.withOpacity(0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading Conversations...',
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(height: 20.0,),
            Container(
              child: SpinKitWave(
                color: Colors.white,
                size: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





