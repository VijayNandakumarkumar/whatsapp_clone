import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/pages/CameraPictureEditPage.dart';
import 'package:whatsapp/pages/CameraVideoEditPage.dart';

List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _cameraController;
  Future<void> cameraValue;
  bool isRecording = false;
  bool isFlashOn = false;
  bool isFrontCamera = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                            isFlashOn
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            isFlashOn
                                ? Icons.flash_on
                                : Icons.flash_off_outlined,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videoPath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return CameraVideoEditPage(
                              path: videoPath.path,
                            );
                          }));
                        },
                        child: InkWell(
                          onTap: () {
                            if (!isRecording) {
                              AlertDialog(
                                title: Text("Hellpooooo"),
                              );
                              capture(context);
                            }
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 70,
                                )
                              : Icon(Icons.panorama_fish_eye,
                                  color: Colors.white, size: 70),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFrontCamera = !isFrontCamera;
                              transform = transform + pi;
                            });
                            int cameraId = isFrontCamera ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraId], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                              angle: transform,
                              child: Icon(Icons.flip_camera_ios,
                                  color: Colors.white, size: 28)))
                    ],
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for video, tap for photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> capture(final BuildContext context) async {
    XFile path = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraPictureEditPage(path: path.path)));
  }
}
