import 'package:flutter/material.dart';
import 'play.dart';
import 'gameLogic.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'play.dart';
import 'dart:math';
import 'dialoguelist.dart';

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
class IntroDialogue extends StatelessWidget {

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
                            Center(child: Image(image: AssetImage('images/talking1.gif'), height: 300.0,)),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Hey there, nice to meet you. Wanna talk to me?.', style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),),
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
                        builder: (context) => Splll(),
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


class Sp extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Sp> {

  @override
  void initState() {
    GameWord game = GameWord();
    // TODO: implement initState
    Timer(Duration(milliseconds: 2100 ), (){
//      print(game.jsonFileContent);
      game.jsonFileContent['words'] = shuffle(game.jsonFileContent['words']);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Play.fromData(game, game.idx);
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





