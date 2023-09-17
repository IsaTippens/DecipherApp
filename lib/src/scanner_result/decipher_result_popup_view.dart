import 'package:flutter/material.dart';

class DecipherResultPopupView extends StatelessWidget {
  const DecipherResultPopupView(
      {Key? key, required this.text, this.title = "Deciphered Text"})
      : super(key: key);
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
