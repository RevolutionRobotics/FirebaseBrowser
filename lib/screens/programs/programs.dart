import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import '../screen_state.dart';

class Programs extends StatefulWidget {

  @override
  createState() => _ProgramsState();
}

class _ProgramsState extends ScreenState {
  
  _ProgramsState() : super('program');

  @override
  Widget card(dynamic item) {
    return Card(
      child: Text(item['name'])
    );
  }
}
