import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

class RobotDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robot details'),
      ),
      body: Center(
        child: Text('Robot')
      ),
    );
  }
}