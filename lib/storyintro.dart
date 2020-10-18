import 'package:flutter/material.dart';
import 'package:game/InteractiveStoryWidget.dart';
import 'play.dart';
import 'gameLogic.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'play.dart';
import 'dart:math';
import 'storyGameLogic.dart';

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

main() {
  var items = ['foo', 'bar', 'baz', 'qux'];

  print(shuffle(items));
}
class StoryIntro extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Game'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              SizedBox(height: 10.0,),
              Card(
                color: Colors.white24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Sp();
                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 320,
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(child: Text('Instructions', style: TextStyle(fontSize: 45.0, color: Colors.black26, fontWeight: FontWeight.bold),)),
//                            SizedBox(height: 10.0,),
//                            Center(child: Image(image: AssetImage('images/game4.png'), color: Colors.black26, height: 180.0,)),
//                            Text('Games', style: TextStyle(fontSize: 45.0, color: Colors.black26, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Card(
                color: Colors.white24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Sp();
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
                            Text('Start Game', style: TextStyle(fontSize: 30.0, color: Colors.black26, fontWeight: FontWeight.bold),)
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


class Sp extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Sp> {

  @override
  void initState() {
    StoryGame story = new StoryGame();
    Timer(Duration(milliseconds: 2100 ), (){
      print(story.presentScene);
      story.LoadStory();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return UnPage.fromData(story);
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
              'Loading Game...',
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





