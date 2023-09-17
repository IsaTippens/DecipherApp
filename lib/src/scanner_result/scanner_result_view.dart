import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'text_recognition.dart';
import 'decipher.dart';
import 'decipher_result_popup_view.dart';

class ScannerResultView extends StatelessWidget {
  final String imagePath;

  const ScannerResultView({super.key, required this.imagePath});

  void _onDecryptPressed(BuildContext context, bool decipher) async {
    String text = await recogniseText(imagePath);
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No text found"),
        ),
      );
      return;
    }
    String? title = null;
    if (decipher) {
      text = Decipher.decipher(text);
    } else {
      title = "Recognised Text";
    }

    _showDecipherResult(context, text, title: title);
  }

  void _showDecipherResult(BuildContext context, String text, {String? title}) {
    showDialog(
      context: context,
      builder: (context) {
        if (title != null) {
          return DecipherResultPopupView(text: text, title: title);
        }
        return DecipherResultPopupView(text: text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Captured Image')),
      body: Center(
        child: Container(child: Image.file(File(imagePath))),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          FloatingActionButton.extended(
            heroTag: 0,
            label: const Text("Read Text"),
            onPressed: () {
              _onDecryptPressed(context, false);
            },
          ),
          Spacer(),
          FloatingActionButton.extended(
            heroTag: 1,
            isExtended: true,
            label: const Text("Decrypt"),
            onPressed: () {
              _onDecryptPressed(context, true);
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
