import 'package:firebase/firebase.dart';
import 'package:flutter_web/material.dart';
import 'package:hzummingbird_test/firebase.dart';

void main() => runApp(RobotBrowserApp());

class RobotBrowserApp extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<RobotBrowserApp> {

  Firebase db = Firebase();

  @override
  void initState() {
    super.initState();
    
    db.listen('robot', (e) {
      setState(() {
        DataSnapshot datasnapshot = e.snapshot;
        String _robot = datasnapshot.val()[0]['name'];

        print(datasnapshot.val());
        print('First robot name: $_robot');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBarDemo(),
    );
  }  
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Robots"),
                Tab(text: "Challanges"),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
