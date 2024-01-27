import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isBulbOn = false;

  @override
  void initState() {
    super.initState();
    loadBulbState();
  }

  void toggleBulb() {
    setState(() {
      isBulbOn = !isBulbOn;
      saveBulbState();
    });
  }

  void saveBulbState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bulbState', isBulbOn);
  }

  void loadBulbState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isBulbOn = prefs.getBool('bulbState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bulb Toggle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isBulbOn ? Icons.lightbulb : Icons.lightbulb_outline,
              size: 100.0,
              color: isBulbOn ? Colors.yellow : Colors.grey,
            ),
            SizedBox(height: 20.0),
            IconButton(
              icon: Icon(Icons.toggle_on),
              onPressed: toggleBulb,
              color: isBulbOn ? Colors.green : Colors.red,
              iconSize: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
