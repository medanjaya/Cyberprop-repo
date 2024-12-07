import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  Widget? cameraPreview;
  late Image image;

  Future setCamera() async {
    cameras = await availableCameras();
    camera = cameras.first;
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    setCamera().then(
      (value) {
        _controller = CameraController(
          camera,
          ResolutionPreset.medium,
        );
        _controller.initialize().then(
          (value) {
            cameraPreview = Center(
              child: CameraPreview(_controller),
            );
            setState(() {
              cameraPreview = cameraPreview;
            });
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: cameraPreview,
    );
  }
}
