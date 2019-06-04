import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:hzummingbird_test/main.dart';

abstract class ScreenState extends State<StatefulWidget> {

  dynamic snapshotValue;
  final String _reference;

  ScreenState(this._reference);

  @override
  void initState() {
    super.initState();

    RobotBrowserApp.db.listen(_reference, (e) {
      setState(() {
        snapshotValue = e.snapshot.val();
      });
    });
  }

  Widget buildWithData();

  @override
  Widget build(BuildContext context) {
    if (snapshotValue != null) {
      return buildWithData();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: CircularProgressIndicator()
          ),
          Text(
            'Loading data...',
            textAlign: TextAlign.center,
          )
        ]
      )
    );
  }
}
