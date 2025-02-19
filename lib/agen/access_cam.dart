import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AccessCamera extends StatefulWidget {
  const AccessCamera({
    super.key
  });

  @override
  State<AccessCamera> createState() => _AccessCameraState();
}

class _AccessCameraState extends State<AccessCamera> {
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
      body: cameraPreview,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            _controller.takePicture().then(
              (value) {
                if (context.mounted) {
                  Navigator.pop(context, value);
                }
              }
            );
          } catch (e) {
            ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}