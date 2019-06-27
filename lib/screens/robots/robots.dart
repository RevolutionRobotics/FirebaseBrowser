import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import '../screen_state.dart';
import 'robot_details.dart';

class Robots extends StatefulWidget {

  @override
  createState() => _RobotsState();
}

class _RobotsState extends ScreenState {
  
  _RobotsState() : super('robot');

  final Map<String, String> _images = {};
  final _placeholder = Image.asset(
    'images/rrf-mark-black-transparent-bg.png',
    fit: BoxFit.contain
  );

  Widget _loadedImageWidget(String key) {
    return _images.containsKey(key)
      ? Image.network(_images[key], fit: BoxFit.cover)
      : _placeholder;
  }

  @override
  Widget card(dynamic item) {
    final String key = item['coverImage'];
    final availableWidth = MediaQuery.of(context).size.width;

    if (!_images.containsKey(key)) {
      getImageUrl(key, (url) {
        setState(() {
          _images[key] = url;
        });
      });
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RobotDetails(item['id'])),
        );
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: _loadedImageWidget(key),
              width: availableWidth,
              height: availableWidth / cardSizeRatio(), 
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(item['name'])
            )
          ]
        ),
      ),
    );
  }
}
