import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import '../robots/robots.dart';
import '../programs/programs.dart';
import '../challenges/challenges.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Robots'),
                Tab(text: 'Programs'),
                Tab(text: 'Challanges')
              ],
            ),
            title: Text('Firebase Browser')
          ),
          body: TabBarView(
            children: [
              Robots(),
              Programs(),
              Challenges()
            ]
          )
        )
      );
  }
}