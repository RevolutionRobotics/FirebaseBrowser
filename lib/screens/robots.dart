import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';

class Robots extends StatelessWidget {

  final dynamic _snapshotValue;

  Robots(this._snapshotValue);

  @override
  Widget build(BuildContext context) {
    if (_snapshotValue == null) {
      return Center(
        child: Text(
          'Loading data...'
        )
      );
    }

    print(_snapshotValue);

    return Center(
      child: Text(
        _snapshotValue[0]['name']
      )
    );
  }
}