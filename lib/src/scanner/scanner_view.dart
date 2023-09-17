import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'about.dart';
import 'scanner_controller.dart';

import '../scanner_result/scanner_result_view.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/scanner';

  final ScannerController controller;

  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  late CameraDescription _camera;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _cameras = widget.controller.cameras;
    _camera = _cameras[index];
    _controller = CameraController(
      _camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Widget _fab(BuildContext context) {
    List<Widget> fabChildren = [
      FloatingActionButton(
        heroTag: 3,
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ScannerResultView(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error taking picture"),
              ),
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    ];

    if (_cameras.length > 1) {
      fabChildren.add(
        FloatingActionButton(
          heroTag: 4,
          onPressed: () {
            setState(() {
              index = (index + 1) % _cameras.length;
              _camera = _cameras[index];
              _controller.setDescription(_camera);
            });
          },
          child: const Icon(Icons.refresh),
        ),
      );
    }

    fabChildren.add(
      FloatingActionButton(
        heroTag: 5,
        onPressed: () {
          _showAboutPopup(context);
        },
        child: const Icon(Icons.info),
      ),
    );

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: fabChildren,
          ),
        ),
      ),
    );
  }

  void _showAboutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AboutPopupView();
      },
    );
  }

  Widget _cameraView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller),
        Positioned(
          top: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
              child: Container(
                alignment: Alignment.center,
                width: size.width,
                padding: const EdgeInsets.all(12.0),
                child: const SafeArea(
                  child: Text(
                    "Point at text to scan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: _fab(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return _cameraView(context);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
