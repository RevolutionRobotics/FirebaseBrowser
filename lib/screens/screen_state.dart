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

  Widget card(dynamic index);

  List<Widget> _buildCards() {
    List<Widget> cells = [];

    snapshotValue.forEach((item) {
      cells.add(card(item));
    });

    return cells;
  }

  Widget _buildWithData() {
    final orientation = MediaQuery.of(context).orientation;
    int count = (orientation == Orientation.landscape) ? 4 : 2;

    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(16),
      crossAxisCount: count,
      childAspectRatio: 0.80,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: _buildCards(),
      shrinkWrap: true
    );
  }

  @override
  Widget build(BuildContext context) {
    if (snapshotValue != null) {
      return _buildWithData();
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
