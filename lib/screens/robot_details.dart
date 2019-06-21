import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'package:hzummingbird_test/main.dart';

class RobotDetails extends StatefulWidget {

  final int robotId;

  RobotDetails(this.robotId, {Key key}): super(key: key);

  @override
  _RobotDetailsState createState() => _RobotDetailsState();
}

class _RobotDetailsState extends State<RobotDetails> {
  String _robotName = "Loading";

  @override
  void initState() {
    super.initState();

    /*RobotBrowserApp.db.listen(_reference, (e) {
      setState(() {
        snapshotValue = e.snapshot.val();
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robot details'),
      ),
      body: Center(child: Text("ID: " + widget.robotId.toString())),
    );
  }
}
