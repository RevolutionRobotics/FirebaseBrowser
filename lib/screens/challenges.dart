import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'screen_state.dart';

class Challenges extends StatefulWidget {

  @override
  createState() => _ChallengesState();
}

class _ChallengesState extends ScreenState {
  
  _ChallengesState() : super('challengeCategory');

  @override
  Widget buildWithData() {
    return Center(
      child: Text(
        snapshotValue[0]['name']
      )
    );
  } 
}
