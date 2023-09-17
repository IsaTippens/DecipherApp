import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

import 'scanner_service.dart';

class ScannerController with ChangeNotifier {
  ScannerController(this._scannerService);

  final ScannerService _scannerService;

  late List<CameraDescription> _cameras;

  List<CameraDescription> get cameras => _cameras;

  Future<List<CameraDescription>> getCameras() async {
    return await _scannerService.getCameras();
  }

  Future<void> fetchCameras() async {
    _cameras = await _scannerService.getCameras();
    notifyListeners();
  }
}
