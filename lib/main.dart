import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:hzummingbird_test/firebase.dart';
import 'package:hzummingbird_test/screens/robots.dart';

void main() => runApp(RobotBrowserApp());

class RobotBrowserApp extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<RobotBrowserApp> {

  Firebase _db = Firebase();
  Map<String, dynamic> _snapshots = {
    'robot'              : null,
    'challengeCategory'  : null,
    'program'            : null
  };

  @override
  void initState() {
    super.initState();

    _snapshots.keys.forEach((ref) {
      _db.listen(ref, (e) {
        setState(() {
          _snapshots[ref] = e.snapshot.val();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_snapshots);
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
                Tab(text: 'Challanges'),
                Tab(text: 'Programs')
              ],
            ),
            title: Text('Robot Browser')
          ),
          body: TabBarView(
            children: [
              Robots(_snapshots['robot']),
              Icon(Icons.directions_transit),
              Icon(Icons.apps)
            ]
          )
        )
      )
    );
  }  
}
