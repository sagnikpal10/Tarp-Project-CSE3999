import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'dart:io';
import 'update.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class updateWidget extends StatefulWidget {
  @override
  _updateWidgetState createState() => _updateWidgetState();
}

class _updateWidgetState extends State<updateWidget> {


  int _state1, _state2, _state3;
  Update up = new Update();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state1 = 0;
    _state2 = 0;
    _state3 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Content", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      body: new Container(
        margin: EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Colors.deepOrangeAccent.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 350,
                      height: 420,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: Image(image: AssetImage('images/update3.png'), height: 240.0,)),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Update your game to download the latest content and stay ahead of the curve", style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new MaterialButton(
                color: Colors.white70.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: setUpButtonChild(),
                onPressed: () {
                  setState(() {
                    if (_state1 == 0) {
                      _state1 = 1;
                      Map<dynamic, dynamic> data;
                      http.get('http://172.26.15.97:8000/api').then((http.Response responce) {
                        data = json.decode(responce.body);
                        _write(data);
                      });

                    }
                  });
                },
                elevation: 4.0,
                minWidth: double.infinity,
                height: 65.0,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new MaterialButton(
                color: Colors.white70.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: setUpButtonChild2(),
                onPressed: () {
                  setState(() {
                    if (_state2 == 0) {
                      _state2 = 1;
                      Map<dynamic, dynamic> data;
                      http.get('http://172.26.15.97:8000/apistory').then((http.Response responce) {
                        print('something');
                        data = json.decode(responce.body);
                        print(data.toString());
                        _writeStory(data);
                      });
                    }
                  });
                },
                elevation: 4.0,
                minWidth: double.infinity,
                height: 65.0,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new MaterialButton(
                color: Colors.white70.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: setUpButtonChild3(),
                onPressed: () {
                  setState(() {
                    if (_state3 == 0) {
                      _state3 = 1;
                      Map<dynamic, dynamic> data;
                      http.get('http://172.26.15.97:8000/convoapi').then((http.Response responce) {
                        data = json.decode(responce.body);
                        _writeDialogue(data);
                      });

                    }
                  });
                },
                elevation: 4.0,
                minWidth: double.infinity,
                height: 65.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _writeDialogue(Map<dynamic, dynamic> text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File(directory.path + '/' + 'dialoguegamenewfile');
    print(directory.path + '/' + 'dialoguegamenewfile');
    await file.writeAsString(json.encode(text));
    print('Conversations Successfully Downloaded Data');
    setState(() {
      _state3 = 2;
    });
  }

  _writeStory(Map<dynamic, dynamic> text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File(directory.path + '/' + 'storygamenewfile');
    print(directory.path + '/' + 'storygamenewfile');
    await file.writeAsString(json.encode(text));
    print('Stories Successfully Downloaded Data');
    setState(() {
      _state2 = 2;
    });
  }

  _write(Map<dynamic, dynamic> text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = new File(directory.path + '/' + 'wordgamenewfile');
    print(directory.path + '/' + 'wordgamenewfile');
//    file.createSync();
    await file.writeAsString(json.encode(text));
    setState(() {
      _state1 = 2;
    });
    print('Words Successfully Downloaded Data');
//    Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
//    print(jsonFileContent["words"]);
      _read();
  }

  _read() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(directory.path + '/' + 'wordgamenewfile');
      Map<dynamic, dynamic> jsonFileContent = json.decode(file.readAsStringSync());
      print(jsonFileContent["words"]);
    } catch (e) {
      print("Couldn't read file");
    }
  }


  Widget setUpButtonChild() {
    if (_state1 == 0) {
      return new Text(
        "Update Word Game",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_state1 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild2() {
    if (_state2 == 0) {
      return new Text(
        "Update Story Game",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_state2 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget setUpButtonChild3() {
    if (_state3 == 0) {
      return new Text(
        "Update Dialogue Game",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_state3 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

}


