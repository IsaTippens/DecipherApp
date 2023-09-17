import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';
import 'src/scanner/scanner_controller.dart';
import 'src/scanner/scanner_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  final ScannerController scannerController =
      ScannerController(ScannerService());
  scannerController.fetchCameras();

  runApp(MyApp(
    scannerController: scannerController,
  ));
}
