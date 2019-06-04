import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'screen_state.dart';

class Robots extends StatefulWidget {

  @override
  createState() => _RobotsState();
}

class _RobotsState extends ScreenState {
  
  _RobotsState() : super('robot');

  @override
  Widget buildWithData() {
    return Center(
      child: Text(
        snapshotValue[0]['name']
      )
    );
  } 
}
