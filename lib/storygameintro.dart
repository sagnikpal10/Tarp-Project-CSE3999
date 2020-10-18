import 'package:flutter/material.dart';
import 'play.dart';
import 'gameLogic.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'play.dart';
import 'dart:math';
import 'storylist.dart';

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {

    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

class IntroStory extends StatelessWidget {

  int idx;
  Intro(int idx){
    this.idx = idx;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Play', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              SizedBox(height: 10.0,),
              Card(
                color: Colors.deepOrangeAccent.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {

                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 320,
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                            Center(child: Text('Instructions', style: TextStyle(fontSize: 45.0, color: Colors.black26, fontWeight: FontWeight.bold),)),
//                            SizedBox(height: 10.0,),
                            Center(child: Image(image: AssetImage('images/story4.png'), height: 250.0,)),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Navigate through the story and interact with it by selecting the right options.', style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Card(
                color: Colors.white70.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Spll(),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 320,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Start Game', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

