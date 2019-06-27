import 'dart:math';
import 'dart:html';

import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'package:revvy_firebase_browser/firebase.dart';
import 'package:revvy_firebase_browser/main.dart';

class RobotDetails extends StatefulWidget {

  final String _robotId;

  RobotDetails(this._robotId, {Key key}): super(key: key);

  @override
  _RobotDetailsState createState() => _RobotDetailsState(_robotId);
}

class _RobotDetailsState extends State<RobotDetails> {

  final String _robotId;
  final _scrollController = ScrollController();
  final _input = FileUploadInputElement();

  dynamic _robotProperties;
  Widget _coverImage;

  double _pageTitleOpacity = 1.0;
  double _titleOverflow = 0.5;

  _RobotDetailsState(this._robotId);

  @override
  void initState() {
    super.initState();

    _initFileInput();
    _scrollController.addListener(() { 
      double offset = _scrollController.offset;
      setState(() {
        _pageTitleOpacity = max(0, 1 - (offset / 150.0));
        _titleOverflow = offset >= 120.0 ? 0.7 : 0.5;
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

    final mediaQuery = MediaQuery.of(context);
    final availableWidth = mediaQuery.size.width * _titleOverflow;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                iconTheme: IconThemeData(color: Colors.white),
                title: Opacity(
                  opacity: _pageTitleOpacity,
                  child: Text('Robot details')
                ),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Container(
                    width: availableWidth,
                    child: Text(
                      _robotProperties['name'],
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                  background: _coverImage,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => _input.click()
                  )
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 20.0, 
                  left: 20.0, 
                  right: 20.0, 
                  bottom: 100.0
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(_formContent()),
                )
              )
            ]
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.save),
            )
          )
        ]
      )
    );
  }

  void _initFileInput() {
    FileReader reader = FileReader();

    reader.onLoad.listen((event) {
      final fileContent = reader.result;
      
      setState(() {
        _coverImage = Container(
          color: Colors.black,
          child: Opacity(
            opacity: 0.8,
            child: Image.memory(fileContent, fit: BoxFit.cover)
          ),
        );
      });
    });

    _input.onInput.listen((event) {
      final file = (event.currentTarget as InputElement).files.first;
      reader.readAsArrayBuffer(file);   
    });
  }

  void _updateCoverImage(String url) {
    setState(() {
      _coverImage = Container(
        color: Colors.black,
        child: Opacity(
          opacity: 0.8,
          child: Image.network(url, fit: BoxFit.cover),
        ),
      );
    });
  }

  List<Widget> _formContent() {
    return <Widget>[
      _textInputItem('name', 'Robot name'),
      _textInputItem('description', 'Description'),
      _textInputItem('buildTime', 'Build time')
    ];
  }

  Widget _textInputItem(String key, String label) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextField(
        controller: TextEditingController(text: _robotProperties[key]),
        decoration: InputDecoration(
          labelText: label
        )
      )
    );
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
