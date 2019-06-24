import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'firebase.dart';
import 'screens/home/home.dart';

void main() => runApp(RobotBrowserApp());

class RobotBrowserApp extends StatelessWidget {

  static final Firebase db = Firebase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Browser',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: Colors.blue
      ),
      home: HomeScreen()
    );
  } 
}
