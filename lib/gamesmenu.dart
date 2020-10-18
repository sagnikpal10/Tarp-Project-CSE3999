import 'package:flutter/material.dart';
import 'wordgameintro.dart';
import 'storylist.dart';
import 'dialoguelist.dart';
import 'storygameintro.dart';
import 'dialogueintro.dart';
import 'dart:async';

class Menu extends StatefulWidget {

  int idx;

  Menu(int idx){
    this.idx = idx;
  }

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool flag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag = true;
    Timer(Duration(milliseconds: 5000 ), (){
      setState(() {
        flag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games Menu', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Visibility(
              visible: flag,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Image.asset('images/arrow-down.gif', height: 150.0, color: Colors.white70.withOpacity(0.5),),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          color: Colors.deepOrangeAccent.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IntroStory(),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 320,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: Image(image: AssetImage('images/story.png'), height: 170.0,)),
                                      SizedBox(height: 25.0,),
                                      Text('Story Based Game', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Card(
                          color: Colors.deepOrangeAccent.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Intro(widget.idx),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 320,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: Image(image: AssetImage('images/word.png'), height: 200.0,)),
                                      SizedBox(height: 5.0,),
                                      Text('Word Guessing Game', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Card(
                          color: Colors.deepOrangeAccent.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IntroDialogue(),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 320,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: Image(image: AssetImage('images/talk-girl.png'), height: 200.0,)),
                                      SizedBox(height: 10.0,),
                                      Text('Dialogue Game', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

