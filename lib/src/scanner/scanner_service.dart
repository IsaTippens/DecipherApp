import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

class ScannerService {
  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }
}
