import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_channel/bridge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool bete = false;

  StreamSubscription<bool> beteListener;

  @override
  void initState() {
    super.initState();
    beteListener = NativeBridge.listenToBadmoodChannel().listen((bt) {
      setState(() {
        this.bete = bt;
      });
    });
  }

  @override
  void dispose() {
    beteListener?.cancel();
    super.dispose();
  }

  void changeBadmood() async {
    NativeBridge.changeBadmood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Is Native in a bad mood?',
            ),
            Text(
              bete ? "YES" : "NO",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: changeBadmood),
    );
  }
}
