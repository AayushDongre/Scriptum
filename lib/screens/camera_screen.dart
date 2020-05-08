import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  CameraScreen({Key key, @required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> _controlleResult;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _controlleResult = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.flash_auto,
                  size: 35,
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.camera,
                  size: 35,
                ),
                onTap: () {
                  ;
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.switch_camera,
                  size: 35,
                ),
              ),
            ],
          )),
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<void>(
          future: _controlleResult,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Text('yes');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
