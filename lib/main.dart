import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamesmenu.dart';
import 'updateWidget.dart';
import 'dart:async';

void main(){
  runApp(HomePage());
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Curve Application',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.red,
        brightness: Brightness.dark,
        fontFamily: 'Pangolin',
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white10,
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            fontFamily: 'Pangolin',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      home: LandingPage(),
    );
  }
}

class menuPage extends StatelessWidget {


  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Curve App', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          color: Colors.black12,
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black12.withOpacity(0.7), BlendMode.dstATop),
            image: AssetImage('images/bgimg2.jpg'),
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Card(
                color: Colors.deepOrangeAccent.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(160.0),
                ),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 350,
                        height: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                            Center(child: Image(image: AssetImage('images/game4.png'), color: Colors.black26, height: 180.0,)),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("Every child has the right to realize one's own potential as a human being", style: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 150.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Colors.white70.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Menu(idx),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(child: Image(image: AssetImage('images/game4.png',), color: Colors.white, height: 70.0,)),
//                            SizedBox(height: 15.0,),
                                Text('Games', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 25.0,),
                  Card(
                    color: Colors.white70.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => updateWidget(),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(child: Image(image: AssetImage('images/download.png',), color: Colors.white, height: 70.0,)),
//                            SizedBox(height: 15.0,),
                                Text('Update', style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class LandingPage extends StatefulWidget {

  @override
  _menuPageState createState() => _menuPageState();
}

class _menuPageState extends State<LandingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 4000 ), (){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return menuPage();
      }));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: new BoxDecoration(
          color: Colors.black12,
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black12.withOpacity(0.3), BlendMode.dstATop),
            image: AssetImage('images/bgimg2.jpg'),
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25.0,),
              Card(
                color: Colors.deepOrangeAccent.withOpacity(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
//                  splashColor: Colors.blue.withAlpha(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 600,
                        height: 800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
//                            Center(child: Image(image: AssetImage('images/game4.png'), color: Colors.black26, height: 180.0,)),
                            SizedBox(height: 250.0,),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset('images/logo.png', height: 300.0,)
                            ),
                            SizedBox(height: 200.0,),
                            Center(child: Text('Developed by Code2Create', style: TextStyle(fontSize: 20.0, color: Colors.white70, fontWeight: FontWeight.bold),)),
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



