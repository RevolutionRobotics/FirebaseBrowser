import 'dart:math';

import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'package:revvy_firebase_browser/firebase.dart';
import 'package:revvy_firebase_browser/main.dart';

class RobotDetails extends StatefulWidget {

  final int _robotId;

  RobotDetails(this._robotId, {Key key}): super(key: key);

  @override
  _RobotDetailsState createState() => _RobotDetailsState(_robotId);
}

class _RobotDetailsState extends State<RobotDetails> {

  final int _robotId;
  final _shadowStyle = TextStyle(
    shadows: [
      Shadow(
        offset: Offset(20.0, 20.0),
        blurRadius: 8.0,
        color: Color.fromARGB(205, 0, 0, 0)
      )
    ]
  );

  ScrollController _scrollController = ScrollController();

  double _opacity = 1.0;
  dynamic _robotProperties;
  Widget _coverImage;

  _RobotDetailsState(this._robotId);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() { 
      double offset = _scrollController.offset;
      setState(() {
        _opacity = max(0, 1 - (offset / 150.0));
      });
    });

    Firebase db = RobotBrowserApp.db;

    db.once('robot/$_robotId', (e) {
      setState(() {
        _robotProperties = e.snapshot.val();
        print('PROPERTIES: $_robotProperties');

        String gsUrl = _robotProperties['coverImage'].toString();
        db.getImageUrl(gsUrl, (url) => _updateCoverImage(url));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_robotProperties == null) {
      return _loadingWidget();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Robot details',
              style: _shadowStyle,
            ),
            pinned: true,
            
            flexibleSpace: FlexibleSpaceBar(
              title: Opacity(
                opacity: _opacity,
                child: Text(
                  _robotProperties['name'],
                  style: _shadowStyle
                )
              ),

              background: _coverImage,
            )
          ),
          SliverFillRemaining(
            child: Text(
              'Content goes here...',
              style: _shadowStyle
            ),
          )
        ]
      )
    );
  }

  void _updateCoverImage(String url) {
    setState(() {
      _coverImage = Image.network(url, fit: BoxFit.cover);
    });
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: CircularProgressIndicator()
          ),
          Text(
            'Loading robot data...',
            textAlign: TextAlign.center,
          )
        ]
      )
    );
  }
}
