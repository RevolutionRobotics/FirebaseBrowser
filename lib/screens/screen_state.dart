import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:revvy_firebase_browser/main.dart';

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

  Widget card(dynamic item);

  List<Widget> _buildCards() {
    List<Widget> cells = [];
    List<String> keys = [];

    snapshotValue.keys.forEach((key) => keys.add(key));

    keys.sort((a, b) => (
      snapshotValue[a]['order']?.compareTo(snapshotValue[b]['order']) ?? 0
    ));

    keys.forEach((key) { 
      cells.add(card(snapshotValue[key]));
    });    

    return cells;
  }

  Future<Uri> getImageUrl(String gsUrl) async {
    return await RobotBrowserApp.db.getImageUrl(gsUrl);
  }

  int cardSizeRatio() {
    final orientation = MediaQuery.of(context).orientation;
    return (orientation == Orientation.landscape) ? 6 : 3;
  }

  Widget _buildWithData() {
    final cards = _buildCards();
    
    if (cards.isEmpty) {
      return Center(
        child: Text(
          'List is empty',
          textAlign: TextAlign.center,
        )
      );
    }

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
