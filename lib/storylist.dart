import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'storyGameLogic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'InteractiveStoryWidget.dart';

class StoryList extends StatefulWidget {

  StoryGame story;
  StoryList.fromData(this.story);

  @override
  _StoryListState createState() => _StoryListState(story);
}

class _StoryListState extends State<StoryList> {


  StoryGame story;
  _StoryListState(this.story);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story List', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
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
                  itemCount: story.jsonData['title'].length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return Card(
                      color: Colors.deepOrangeAccent.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          story.storyTitle = story.jsonData['title'][Index];
                          print(Index);
                          print(story.storyTitle);
                          story.sceneIdx = 0;
                          story.readStory();
                          story.LoadStory();
                          print(story.sceneIdx);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return UnPage.fromData(story);
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
                                  Text(story.jsonData['title'][Index], style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),)
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


class Spll extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Spll> {

  @override
  void initState() {
    StoryGame story = new StoryGame();
    Timer(Duration(milliseconds: 2100 ), (){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return StoryList.fromData(story);
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
              'Loading Stories...',
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





