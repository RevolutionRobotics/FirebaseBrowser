import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'firebase.dart';
import 'screens/robots.dart';
import 'screens/programs.dart';
import 'screens/challenges.dart';

void main() => runApp(RobotBrowserApp());

class RobotBrowserApp extends StatelessWidget {

  static final Firebase db = Firebase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Browser',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: Colors.blue
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Robots'),
                Tab(text: 'Programs'),
                Tab(text: 'Challanges')
              ],
            ),
            title: Text('Robot Browser')
          ),
          body: TabBarView(
            children: [
              Robots(),
              Programs(),
              Challenges()
            ]
          )
        )
      )
    );
  } 
}
