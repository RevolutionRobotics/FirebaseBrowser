import 'dart:html';

import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
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
  final _input = FileUploadInputElement()..accept = 'image/*';

  final Map<String, String> _images = {};
  final _placeholder = Image.asset(
    'images/rrf-mark-black-transparent-bg.png',
    fit: BoxFit.contain
  );

  double _titleOverflow = 0.5;
  dynamic _robotProperties;
  
  dynamic _buildSteps;
  int _currentBuildStep = 0;

  Widget _coverImage;
  File _selectedImage;

  _RobotDetailsState(this._robotId);

  @override
  void initState() {
    super.initState();

    _initFileInput();
    _scrollController.addListener(() { 
      double offset = _scrollController.offset;

      if (offset >= 120.0 && _titleOverflow == 0.5) {
        setState(() {
          _titleOverflow = 0.7;
        });
      } else if (offset < 120.0 && _titleOverflow == 0.7) {
        setState(() {
          _titleOverflow = 0.5;
        });
      }
    });

    Firebase db = RobotBrowserApp.db;

    db.once('robot/$_robotId', (robot) {
      final robotSnapshot = robot.snapshot.val();

      db.once('buildStep', (steps) {
        setState(() {
          _buildSteps = steps.snapshot.val()..removeWhere((k, v) => (
            v['robotId'] != robotSnapshot['id']
          ));
        });
      });

      setState(() {
        _robotProperties = robotSnapshot;
        print('PROPERTIES: $_robotProperties');

        String gsUrl = _robotProperties['coverImage'].toString();
        db.getImageUrl(gsUrl).then((url) => _updateCoverImage(url.toString()));
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
              onPressed: () => setState(() {
                final db = RobotBrowserApp.db;
                final ref = 'robot/$_robotId';

                if (_selectedImage != null) {
                  db.updateImage(ref, _selectedImage).then((value) {
                    _robotProperties['coverImage'] = value;
                    db.update(ref, _robotProperties);

                    _selectedImage = null;
                  });
                } else {
                  db.update(ref, _robotProperties);
                }
              }),
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
      final image = Image.memory(reader.result, fit: BoxFit.cover);
      
      setState(() {
        _coverImage = _headerImageContainer(image);
      });
    });

    _input.onInput.listen((event) {
      if (_input.files?.length != 1) {
        return;
      }

      _selectedImage = _input.files.first;
      reader.readAsArrayBuffer(_selectedImage);
    });
  }

  void _updateCoverImage(String url) {
    final image = Image.network(url, fit: BoxFit.cover);

    setState(() {
      _coverImage = _headerImageContainer(image);
    });
  }

  List<Widget> _formContent() {
    return <Widget>[
      _textInputItem('name', 'Robot name'),
      _textInputItem('defaultProgram', 'Default program'),
      _textInputItem('description', 'Description'),
      _textInputItem('buildTime', 'Build time'),
      Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(
          child: Text(
            'Build flow editor',
            style: Theme.of(context).textTheme.title,
          )
        )
      ),
      (_buildSteps == null) 
        ? Text('Loading build steps...') 
        : _buildStepsWidget()
    ];
  }

  Widget _headerImageContainer(Image child) {
    return Container(
      color: Colors.black,
      child: Opacity(
        opacity: 0.8,
        child: child,
      ),
    );
  }

  Widget _textInputItem(String key, String label) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextField(
        controller: TextEditingController(text: _robotProperties[key]),
        onChanged: (text) =>_robotProperties[key] = text,
        decoration: InputDecoration(
          labelText: label
        )
      )
    );
  }

  Widget _buildStepsWidget() {
    List<Step> stepsList = [];

    _buildSteps.keys.toList()
      ..sort((String a, String b) => (
        _buildSteps[a]['stepNumber']?.compareTo(_buildSteps[b]['stepNumber']) as int ?? 0
      ))
      ..forEach((key) {
        final step = _buildSteps[key];

        RobotBrowserApp.db.getImageUrl(step['image']).then((url) {
          if (!_images.keys.contains(key)) {
            setState(() {
              _images[key] = url.toString();
            });
          }
        });

        stepsList.add(Step(
          title: Text('Step ${step['stepNumber']}'),
          content: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              (_images.keys.contains(key)
                ? Image.network(
                  _images[key], 
                  fit: BoxFit.fitWidth,
                  width: 300
                )
                : _placeholder
              )
            ]
          )
        ));
      });

    return Padding(
      padding: EdgeInsets.all(20),
      child: Stepper(
        steps: stepsList,
        currentStep: _currentBuildStep,
        onStepTapped: (step) {
          setState(() {
            _currentBuildStep = step;
          });
        },
        controlsBuilder: (context, { onStepContinue, onStepCancel }) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Change image'),
                onPressed: () => print('Change image button pressed')
              )
            ]
          );
        }
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
            textAlign: TextAlign.center
          )
        ]
      )
    );
  }
}
