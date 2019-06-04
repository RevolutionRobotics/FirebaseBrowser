import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'screen_state.dart';

class Programs extends StatefulWidget {

  @override
  createState() => _ProgramsState();
}

class _ProgramsState extends ScreenState {
  
  _ProgramsState() : super('program');

  @override
  Widget buildWithData() {
    return Center(
      child: Text(
        snapshotValue[0]['name']
      )
    );
  } 
}
