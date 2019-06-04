import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'screen_state.dart';

class Robots extends StatefulWidget {

  @override
  createState() => _RobotsState();
}

class _RobotsState extends ScreenState {
  
  _RobotsState() : super('robot');

  @override
  Widget card(dynamic item) {
    return Card(
      child: Text(item['name'])
    );
  }
}
